function Get-WrapperFunctionName {
    param (
        [string]$WrappedFunction,
        [string]$Day,
        [string]$Nth
    )

    # Write-Host "[$($MyInvocation.MyCommand.Name)] ParameterSetName: $($PsCmdlet.ParameterSetName)"
    # Write-Host "[$($MyInvocation.MyCommand.Name)] PSBoundParameters: $($PSBoundParameters | Out-String)"


    $last = ($WrappedFunction -match 'Last') ? "Last" : ""
    $Nth = ($last -and $Nth -eq '1st') ? "" : $Nth

    return "Get-$($Nth)$($last)$($Day)OfMonth"
}

function Get-WrapperFunctionContent {
    param (
        [string]$functionName,
        [string]$wrappedFunction,
        [string]$day,
        [int]$week
    )
    $alias = if ($week -eq 2 -and $day -eq "Tuesday") { "Get-PatchTuesday" } else { "" }
    # write-host "$($functionName) - $($wrappedFunction)"

    return @"
function $functionName {
    [Alias('$alias')]
    [CmdletBinding()]
    [OutputType([System.DateTime])]
    param (
        [Parameter(Mandatory)][int]`$Month,
        [Parameter(Mandatory)][int]`$Year
    )
    $wrappedFunction -Year `$Year -Month `$Month -WeekDay $day -Nth $week
}
"@
}

function Get-WrapperFunctionTestContent {
param (
    [string]$functionName,
    [string]$wrappedFunction,
    [string]$day,
    [int]$week
)
    return @"

    It "$functionName calls $wrappedFunction with correct parameters" {

        # Mock $wrappedFunction { return `$null }
        . `$TopLevel\Source\Generated\$functionName.ps1
        $functionName -Month 1 -Year 2023
        Should -Invoke $wrappedFunction -Exactly -Times 1 -ParameterFilter {
            `$Month -eq 1 -and `$Year -eq 2023 -and `$WeekDay -eq [System.DayOfWeek]::$day -and `$Nth -eq $week
        }
    }
"@
}
