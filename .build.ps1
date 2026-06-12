$repoRoot = $PSScriptRoot
$sourceManifestPath = Join-Path $repoRoot 'Source\psDateFunctions.psd1'
$buildPreferencesPath = Join-Path $repoRoot 'build.psd1'
$testPath = Join-Path $repoRoot 'Source\Tests'
$changelogPath = Join-Path $repoRoot 'CHANGELOG.md'
$outputRootPath = Join-Path $repoRoot 'Output'

task Validate {
    foreach ($path in @(
            $sourceManifestPath
            $buildPreferencesPath
            $testPath
            $changelogPath
        )) {
        if (-not (Test-Path $path)) {
            throw "Required build input not found: $path"
        }
    }

    $null = Import-PowerShellDataFile $sourceManifestPath
    $null = Import-PowerShellDataFile $buildPreferencesPath
}

task Analyze Validate, {
    $parseFailures = [System.Collections.Generic.List[string]]::new()
    $scriptFiles = Get-ChildItem -Path $repoRoot -Recurse -File -Include *.ps1, *.psm1

    foreach ($file in $scriptFiles) {
        $tokens = $null
        $errors = $null
        [System.Management.Automation.Language.Parser]::ParseFile($file.FullName, [ref]$tokens, [ref]$errors) > $null

        if ($errors.Count -gt 0) {
            $errorSummary = ($errors | ForEach-Object { $_.Message }) -join '; '
            $parseFailures.Add("$($file.FullName): $errorSummary")
        }
    }

    if ($parseFailures.Count -gt 0) {
        throw "PowerShell syntax analysis failed:`n$($parseFailures -join "`n")"
    }
}

task Test Validate, Analyze, {
    Import-Module Pester -ErrorAction Stop

    $config = New-PesterConfiguration
    $config.Output.Verbosity = 'Detailed'
    $config.Run.Path = $testPath
    $config.Run.Throw = $true

    Invoke-Pester -Configuration $config
}

task Clean {
    Write-Host 'Clear previous builds from Output...' -ForegroundColor Cyan
    if (Test-Path $outputRootPath) {
        Get-ChildItem -Path $outputRootPath -Force | Remove-Item -Recurse -Force
    }
}

task Build Clean, Validate, {
    Import-Module ModuleBuilder -ErrorAction Stop
    Build-Module
}

task . Build
