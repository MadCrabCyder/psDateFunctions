$repoRoot = $PSScriptRoot
$sourceManifestPath = Join-Path $repoRoot 'Source\psDateFunctions.psd1'
$buildPreferencesPath = Join-Path $repoRoot 'build.psd1'
$testPath = Join-Path $repoRoot 'Source\Tests'
$changelogPath = Join-Path $repoRoot 'CHANGELOG.md'
$outputRootPath = Join-Path $repoRoot 'Output'
$buildOutputPath = Join-Path $outputRootPath 'psDateFunctions'
$buildOutputManifestPath = Join-Path $buildOutputPath 'psDateFunctions.psd1'

function Get-SourceManifest {
    Import-PowerShellDataFile $sourceManifestPath
}

function Assert-ChangelogVersionMatch {
    $sourceManifest = Get-SourceManifest
    $version = $sourceManifest.ModuleVersion

    $changelogContent = Get-Content $changelogPath -Raw
    if ($changelogContent -notmatch '## (?<Version>\d+\.\d+\.\d+) \(') {
        throw 'Could not determine latest version from CHANGELOG.md.'
    }

    $latestChangelogVersion = $matches.Version
    if ($latestChangelogVersion -ne $version) {
        throw "Source manifest version '$version' does not match latest CHANGELOG.md version '$latestChangelogVersion'."
    }

    return $version
}

function Assert-BuiltManifestVersionMatch {
    param(
        [Parameter(Mandatory)]
        [string]$Version
    )

    if (-not (Test-Path $buildOutputManifestPath)) {
        throw "Built manifest not found: $buildOutputManifestPath"
    }

    $builtManifest = Import-PowerShellDataFile $buildOutputManifestPath
    if ($builtManifest.ModuleVersion -ne $Version) {
        throw "Built manifest version '$($builtManifest.ModuleVersion)' does not match source version '$Version'."
    }
}

function Publish-BuiltModule {
    param(
        [Parameter(Mandatory)]
        [string]$Version,
        [switch]$WhatIf
    )

    if (-not $env:PSGALLERY_API_KEY) {
        throw 'Set PSGALLERY_API_KEY before running a publish task.'
    }

    Write-Host "Publishing $Version from $buildOutputPath..." -ForegroundColor Cyan
    Publish-Module `
        -Path $buildOutputPath `
        -Repository PSGallery `
        -NuGetApiKey $env:PSGALLERY_API_KEY `
        -SkipAutomaticTags `
        -WhatIf:$WhatIf
}

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

task PublishValidate Validate, {
    Assert-ChangelogVersionMatch > $null
}

task PublishBuilt PublishValidate, {
    $version = Assert-ChangelogVersionMatch
    Assert-BuiltManifestVersionMatch -Version $version
    Publish-BuiltModule -Version $version
}

task PublishBuiltWhatIf PublishValidate, {
    $version = Assert-ChangelogVersionMatch
    Assert-BuiltManifestVersionMatch -Version $version
    Publish-BuiltModule -Version $version -WhatIf
}

task Publish Test, Build, PublishBuilt

task PublishWhatIf Test, Build, PublishBuiltWhatIf

task . Build
