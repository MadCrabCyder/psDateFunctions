# These functions are used to generate the wrapper functions
# but are not included in the actual module

function Get-OrdinalNumber {
    param (
        [int]$Num
    )
    $Suffix = switch -regex ($Num) {
        '1(1|2|3)$' { 'th'; break }
        '.?1$'      { 'st'; break }
        '.?2$'      { 'nd'; break }
        '.?3$'      { 'rd'; break }
        default     { 'th'; break }
    }
    return "$Num$Suffix"
}

# function Get-WrapperFunctionName {
#     param (
#         [string]$WrappedFunction,
#         [string]$Day,
#         [string]$Nth
#     )

#     $last = ($WrappedFunction -match 'Last') ? "Last" : ""
#     $Nth = ($last -and $Nth -eq '1st') ? "" : $Nth

#     return "Get-$($Nth)$($last)$($Day)OfMonth"
# }

# function Get-WrapperFunctionDescription {
#     param (
#         [string]$WrappedFunction,
#         [string]$Day,
#         [string]$NthOrd
#     )
#     $last = ($WrappedFunction -match 'Last') ? "Last" : ""
#     $NthOrd = ($last -and $NthOrd -eq '1st') ? "" : $NthOrd

#     return "$($NthOrd) $($last) $($Day)" -replace '\s\s+',' ' -replace '^\s+',''

# }

function Get-WrapperFunctionDetails {
    param (
        [string]$WrappedFunction,
        [string]$Day,
        [int]$N
    )
    $last = if ($WrappedFunction -match 'Last') { 'Last' } else { '' }

    $NthOrd = if ($last -and $N -eq 1) { "" } else { Get-OrdinalNumber -Num $N }

    $description = "$($NthOrd) $($last) $($Day)" -replace '\s\s+', ' ' -replace '^\s+', ''

    $functionName = "Get-$($description -replace '\s','' )OfMonth"

    $alias = if ($N -eq 2 -and $Day -eq "Tuesday" -and -not $last) { "Get-PatchTuesday" } else { "" }

    return @{ FunctionName = $functionName; Description = $description; Alias = $alias }
}

function Get-WrapperFunctionContent {
    param (
        [Hashtable]$FunctionDetails,
        [string]$wrappedFunction,
        [string]$Day,
        [int]$N

    )
    # $alias = if ($week -eq 2 -and $day -eq "Tuesday") { "Get-PatchTuesday" } else { "" }
    # $last = ($WrappedFunction -match 'Last') ? "Last " : ""
    # $NthOrd = ($last -and $NthOrd -eq '1st') ? "" : "$NthOrd"

    # $description = Get-WrapperFunctionDescription -WrappedFunction $wrappedFunction -Day $day -NthOrd $NthOrd
    # # write-host "$($functionName) - $($wrappedFunction)"


    return @"
<#
.SYNOPSIS
Calculates the date of the $($FunctionDetails.Description) of a specified month and year.

.DESCRIPTION
The $($FunctionDetails.functionName) function calculates the date of the $($FunctionDetails.Description) in the specified month and year. It simplifies the process of identifying the date for scheduling events or meetings that recur on the $($FunctionDetails.Description) of a month.

.PARAMETER Month
The numeric value representing the month. This parameter is mandatory and must be an integer between 1 (January) and 12 (December).

.PARAMETER Year
The numeric value representing the year. This parameter is mandatory and must be a integer between 1 and 9999.

.EXAMPLE
$($FunctionDetails.functionName) -Month 9 -Year 2024

This command returns the date of the $($FunctionDetails.Description) of September 2024.

.EXAMPLE
`$day = $($FunctionDetails.functionName) -Month 12 -Year 2023
Write-Output "The $($FunctionDetails.Description) of December 2023 is on: `$day"

Calculates the $($FunctionDetails.Description) of December 2023, assigns it to the variable `$day, and prints it.

.INPUTS
None. You cannot pipe input to $($FunctionDetails.functionName).

.OUTPUTS
System.DateTime
This function returns a System.DateTime object representing the $($FunctionDetails.Description) of the given month and year.

.NOTES
This function is a wrapper around $wrappedFunction, specifically configured to find the $($FunctionDetails.Description) of the month. Ensure the 'Month' and 'Year' parameters are within their valid ranges to avoid exceptions.

#>
function $($FunctionDetails.functionName) {
    [Alias('$($FunctionDetails.Alias)')]
    [OutputType([System.DateTime])]
    param (
        [Parameter(Mandatory)][int]`$Month,
        [Parameter(Mandatory)][int]`$Year
    )
    $wrappedFunction -Year `$Year -Month `$Month -WeekDay $Day -Nth $N
}
"@
}

# function Get-WrapperFunctionTestContent {
# param (
#     [string]$functionName,
#     [string]$wrappedFunction,
#     [string]$day,
#     [int]$week
# )
#     return @"

#     It "$functionName calls $wrappedFunction with correct parameters" {

#         # Mock $wrappedFunction { return `$null }
#         . `$TopLevel\Source\Generated\$functionName.ps1
#         $functionName -Month 1 -Year 2023
#         Should -Invoke $wrappedFunction -Exactly -Times 1 -ParameterFilter {
#             `$Month -eq 1 -and `$Year -eq 2023 -and `$WeekDay -eq [System.DayOfWeek]::$day -and `$Nth -eq $week
#         }
#     }
# "@
# }
