<#
.SYNOPSIS
Returns the first weekday of a specified month and year.

.DESCRIPTION
Wraps Get-1stDayInMonth with the -Weekday switch to simplify access to the first valid weekday.

.PARAMETER Month
The numeric value representing the month. This parameter is mandatory and must be an integer between 1 (January) and 12 (December).

.PARAMETER Year
The numeric value representing the year. This parameter is mandatory and must be a integer between 1 and 9999.

.PARAMETER ExcludeDays
An optional array of [System.DayOfWeek] values to exclude. When provided, the function skips over any days of the week listed here and returns the first day of the month that is not in the list. This parameter overrides the default exclusions set by -Weekday.

#>
function Get-1stWeekdayInMonth {
    [Alias('Get-FirstWeekdayInMonth')]
    [CmdletBinding()]
    [OutputType([datetime])]
    param (
        [Parameter(Mandatory)][int]$Month,
        [Parameter(Mandatory)][int]$Year,

        [DayOfWeek[]]$ExcludeDays
    )

    return Get-1stDayInMonth -Month $Month -Year $Year -Weekday -ExcludeDays:$ExcludeDays
}
