<#
.SYNOPSIS
Calculates the date of the 5th Last Monday of a specified month and year.

.DESCRIPTION
The Get-5thLastMondayOfMonth function calculates the date of the 5th Last Monday in the specified month and year. It simplifies the process of identifying the date for scheduling events or meetings that recur on the 5th Last Monday of a month.

.PARAMETER Month
The numeric value representing the month. This parameter is mandatory and must be an integer between 1 (January) and 12 (December).

.PARAMETER Year
The numeric value representing the year. This parameter is mandatory and must be a integer between 1 and 9999.

.EXAMPLE
Get-5thLastMondayOfMonth -Month 9 -Year 2024

This command returns the date of the 5th Last Monday of September 2024.

.EXAMPLE
$day = Get-5thLastMondayOfMonth -Month 12 -Year 2023
Write-Output "The 5th Last Monday of December 2023 is on: $day"

Calculates the 5th Last Monday of December 2023, assigns it to the variable $day, and prints it.

.INPUTS
None. You cannot pipe input to Get-5thLastMondayOfMonth.

.OUTPUTS
System.DateTime
This function returns a System.DateTime object representing the 5th Last Monday of the given month and year.

.NOTES
This function is a wrapper around Get-NthLastWeekdayOfMonth, specifically configured to find the 5th Last Monday of the month. Ensure the 'Month' and 'Year' parameters are within their valid ranges to avoid exceptions.

#>
function Get-5thLastMondayOfMonth {
    [Alias('')]
    [OutputType([System.DateTime])]
    param (
        [Parameter(Mandatory)][int]$Month,
        [Parameter(Mandatory)][int]$Year
    )
    Get-NthLastWeekdayOfMonth -Year $Year -Month $Month -WeekDay Monday -Nth 5
}
