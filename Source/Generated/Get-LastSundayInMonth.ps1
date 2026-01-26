<#
.SYNOPSIS
Calculates the date of the Last Sunday of a specified month and year.

.DESCRIPTION
The Get-LastSundayInMonth function calculates the date of the Last Sunday in the specified month and year. It simplifies the process of identifying the date for scheduling events or meetings that recur on the Last Sunday of a month.

.PARAMETER Month
The numeric value representing the month. This parameter is mandatory and must be an integer between 1 (January) and 12 (December).

.PARAMETER Year
The numeric value representing the year. This parameter is mandatory and must be a integer between 1 and 9999.

.EXAMPLE
Get-LastSundayInMonth -Month 9 -Year 2024

This command returns the date of the Last Sunday of September 2024.

.EXAMPLE
$day = Get-LastSundayInMonth -Month 12 -Year 2023
Write-Output "The Last Sunday of December 2023 is on: $day"

Calculates the Last Sunday of December 2023, assigns it to the variable $day, and prints it.

.INPUTS
None. You cannot pipe input to Get-LastSundayInMonth.

.OUTPUTS
System.DateTime
This function returns a System.DateTime object representing the Last Sunday of the given month and year.

.NOTES
This function is a wrapper around Get-NthLastDayOfWeekInMonth, specifically configured to find the Last Sunday of the month. Ensure the 'Month' and 'Year' parameters are within their valid ranges to avoid exceptions.

#>
function Get-LastSundayInMonth {
    [OutputType([System.DateTime])]
    param (
        [Parameter(Mandatory)][int]$Month,
        [Parameter(Mandatory)][int]$Year
    )
    Get-NthLastDayOfWeekInMonth -Year $Year -Month $Month -DayOfWeek Sunday -Nth 1
}
