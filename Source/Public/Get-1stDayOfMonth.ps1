<#
.SYNOPSIS
Calculates the first day of a specified month and year, with optional filtering to return the first Weekday.

.DESCRIPTION
The Get-1stDayOfMonth function calculates and returns the first day of a given month and year as a System.DateTime object. It also supports filtering out specific days of the week (such as weekends) to return the first valid "Weekday"

.PARAMETER Month
The numeric value representing the month. This parameter is mandatory and must be an integer between 1 (January) and 12 (December).

.PARAMETER Year
The numeric value representing the year. This parameter is mandatory and must be a integer between 1 and 9999.

.PARAMETER Weekday
If specified, the function excludes Saturday and Sunday by default and returns the first day of the month that is not a weekend. This is a convenience switch.

.PARAMETER ExcludeDays
An optional array of [System.DayOfWeek] values to exclude. When provided, the function skips over any days of the week listed here and returns the first day of the month that is not in the list. This parameter overrides the default exclusions set by -Weekday.

.EXAMPLE
Get-1stDayOfMonth -Month 7 -Year 2024

Returns the first day of July 2024 as a System.DateTime object.

.EXAMPLE
$firstDay = Get-1stDayOfMonth -Month 12 -Year 2023
Write-Output "The first day of December 2023 is: $firstDay"

Calculates the first day of December 2023, assigns it to the variable $firstDay, and prints it.

.EXAMPLE
Get-1stDayOfMonth -Month 1 -Year 2026 -Weekday

Returns the first weekday (Monday to Friday) of January 2026, excluding Saturday and Sunday.

.EXAMPLE
Get-1stDayOfMonth -Month 2 -Year 2026 -ExcludeDays Sunday, Saturday, Friday

Returns the first day of February 2026 that is not Sunday, Saturday, or Friday.

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
        [Parameter(Mandatory)][int]$Year,
        [switch]$Weekday,
        [DayOfWeek[]]$ExcludeDays
    )
    if ($Month -lt 1 -or $Month -gt 12) { throw 'Invalid Month'}
    if ($Year -lt 1 -or $Year -gt 9999) { throw 'Invalid Year'}

    # Set default exclude days to weekend if -Weekday is passed and -ExcludeDays is not set
    if ($Weekday -and -not $ExcludeDays) {
        $ExcludeDays = @([DayOfWeek]::Saturday, [DayOfWeek]::Sunday)
    }

    $date = Get-Date -Year $Year -Month $Month -Day 1

    while ($ExcludeDays -and $ExcludeDays -contains $date.DayOfWeek) {
        $date = $date.AddDays(1)
    }

    return $date.Date

}
