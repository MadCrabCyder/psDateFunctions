<#
.SYNOPSIS
Calculates the first day of a specified month and year.

.DESCRIPTION
The Get-1stDayOfMonth function calculates and returns the first day of a given month and year as a System.DateTime object. This can be useful for scheduling, planning, and any operations that require the starting date of a month.

.PARAMETER Month
The numeric value representing the month. This parameter is mandatory and must be an integer between 1 (January) and 12 (December).

.PARAMETER Year
The numeric value representing the year. This parameter is mandatory and must be a integer between 1 and 9999.

.EXAMPLE
Get-1stDayOfMonth -Month 7 -Year 2024

Returns the first day of July 2024 as a System.DateTime object.

.EXAMPLE
$firstDay = Get-1stDayOfMonth -Month 12 -Year 2023
Write-Output "The first day of December 2023 is: $firstDay"

Calculates the first day of December 2023, assigns it to the variable $firstDay, and prints it.

.INPUTS
None. You cannot pipe objects to Get-1stDayOfMonth.

.OUTPUTS
System.DateTime
Returns a System.DateTime object representing the first day of the specified month and year.

.NOTES
The function checks if the provided month is within the valid range (1-12). An exception is thrown for invalid month values to ensure reliability in date calculations.

#>
function Get-1stDayOfMonth {
    [Alias('Get-FirstDayOfMonth')]
    [OutputType([System.DateTime])]
    param (
        [Parameter(Mandatory)][int]$Month,
        [Parameter(Mandatory)][int]$Year
    )
    if ($Month -lt 1 -or $Month -gt 12) { throw 'Invalid Month'}
    if ($Year -lt 1 -or $Year -gt 9999) { throw 'Invalid Year'}
    return (Get-Date -Year $Year -Month $Month -Day 1).Date
}
