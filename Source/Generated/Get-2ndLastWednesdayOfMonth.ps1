<#
.SYNOPSIS
Calculates the date of the 2nd Last Wednesday of a specified month and year.

.DESCRIPTION
The Get-2ndLastWednesdayOfMonth function calculates the date of the 2nd Last Wednesday in the specified month and year. It simplifies the process of identifying the date for scheduling events or meetings that recur on the 2nd Last Wednesday of a month.

.PARAMETER Month
The numeric value representing the month. This parameter is mandatory and must be an integer between 1 (January) and 12 (December).

.PARAMETER Year
The numeric value representing the year. This parameter is mandatory and must be a integer between 1 and 9999.

.EXAMPLE
Get-2ndLastWednesdayOfMonth -Month 9 -Year 2024

This command returns the date of the 2nd Last Wednesday of September 2024.

.EXAMPLE
$day = Get-2ndLastWednesdayOfMonth -Month 12 -Year 2023
Write-Output "The 2nd Last Wednesday of December 2023 is on: $day"

Calculates the 2nd Last Wednesday of December 2023, assigns it to the variable $day, and prints it.

.INPUTS
None. You cannot pipe input to Get-2ndLastWednesdayOfMonth.

.OUTPUTS
System.DateTime
This function returns a System.DateTime object representing the 2nd Last Wednesday of the given month and year.

.NOTES
This function is a wrapper around Get-NthLastWeekdayOfMonth, specifically configured to find the 2nd Last Wednesday of the month. Ensure the 'Month' and 'Year' parameters are within their valid ranges to avoid exceptions.

#>
function Get-2ndLastWednesdayOfMonth {
    [Alias('')]
    [OutputType([System.DateTime])]
    param (
        [Parameter(Mandatory)][int]$Month,
        [Parameter(Mandatory)][int]$Year
    )
    Get-NthLastWeekdayOfMonth -Year $Year -Month $Month -WeekDay Wednesday -Nth 2
}
