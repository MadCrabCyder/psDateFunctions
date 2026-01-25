<#
.SYNOPSIS
Calculates the date of the 3rd Thursday of a specified month and year.

.DESCRIPTION
The Get-3rdThursdayInMonth function calculates the date of the 3rd Thursday in the specified month and year. It simplifies the process of identifying the date for scheduling events or meetings that recur on the 3rd Thursday of a month.

.PARAMETER Month
The numeric value representing the month. This parameter is mandatory and must be an integer between 1 (January) and 12 (December).

.PARAMETER Year
The numeric value representing the year. This parameter is mandatory and must be a integer between 1 and 9999.

.EXAMPLE
Get-3rdThursdayInMonth -Month 9 -Year 2024

This command returns the date of the 3rd Thursday of September 2024.

.EXAMPLE
$day = Get-3rdThursdayInMonth -Month 12 -Year 2023
Write-Output "The 3rd Thursday of December 2023 is on: $day"

Calculates the 3rd Thursday of December 2023, assigns it to the variable $day, and prints it.

.INPUTS
None. You cannot pipe input to Get-3rdThursdayInMonth.

.OUTPUTS
System.DateTime
This function returns a System.DateTime object representing the 3rd Thursday of the given month and year.

.NOTES
This function is a wrapper around Get-NthDayOfWeekInMonth, specifically configured to find the 3rd Thursday of the month. Ensure the 'Month' and 'Year' parameters are within their valid ranges to avoid exceptions.

#>
function Get-3rdThursdayInMonth {
    [Alias('')]
    [OutputType([System.DateTime])]
    param (
        [Parameter(Mandatory)][int]$Month,
        [Parameter(Mandatory)][int]$Year
    )
    Get-NthDayOfWeekInMonth -Year $Year -Month $Month -DayOfWeek Thursday -Nth 3
}
