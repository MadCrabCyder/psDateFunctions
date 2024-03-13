# Run all tests
#

$config = New-PesterConfiguration
$config.Output.Verbosity = 'Detailed'
$config.Run.Path = (Join-Path $PSScriptRoot 'Source\Tests')
$config.Run.Throw = $true
Invoke-Pester -Configuration $config
