<#
.SYNOPSIS
Calculates the last day of a specified month and year.

.DESCRIPTION
The Get-LastDayInMonth function calculates and returns the last day of a given month and year as a System.DateTime object. It is particularly useful for end-of-month calculations, billing cycles, and planning monthly tasks or events.

.PARAMETER Month
The numeric value representing the month. This parameter is mandatory and must be an integer between 1 (January) and 12 (December).

.PARAMETER Year
The numeric value representing the year. This parameter is mandatory and must be a integer between 1 and 9999.

.PARAMETER Weekday
If specified, the function excludes Saturday and Sunday by default and returns the first day of the month that is not a weekend. This is a convenience switch.

.PARAMETER ExcludeDays
An optional array of [System.DayOfWeek] values to exclude. When provided, the function skips over any days of the week listed here and returns the first day of the month that is not in the list. This parameter overrides the default exclusions set by -Weekday.

.EXAMPLE
Get-LastDayInMonth -Month 7 -Year 2024

Returns the last day of July 2024 as a System.DateTime object.

.EXAMPLE
$lastDay = Get-LastDayInMonth -Month 12 -Year 2023
Write-Output "The last day of December 2023 is: $lastDay"

Calculates the last day of December 2023, stores it in the variable $lastDay, and prints it out. Useful for end-of-year processing.

.INPUTS
None. You cannot pipe objects to Get-LastDayInMonth.

.OUTPUTS
System.DateTime
Returns a System.DateTime object representing the last day of the specified month and year.

.NOTES
The function checks if the provided month is within the valid range (1-12). An exception is thrown for invalid month values to ensure reliability in date calculations.

#>
function Get-LastDayInMonth {
    [OutputType([System.DateTime])]
    param (
        [Parameter(Mandatory)][int]$Month,
        [Parameter(Mandatory)][int]$Year,
        [switch]$Weekday,
        [DayOfWeek[]]$ExcludeDays
    )
    if ($Month -lt 1 -or $Month -gt 12) { throw 'Invalid Month'}
    if ($Year -lt 1 -or $Year -gt 9999) { throw 'Invalid Year'}
    # Set default exclude days to weekend if -Weekday is passed and -ExcludeDays is not
    if ($Weekday -and -not $ExcludeDays) {
        $ExcludeDays = @([DayOfWeek]::Saturday, [DayOfWeek]::Sunday)
    }

    $date = (Get-Date -Year $Year -Month ($Month+1) -Day 1).Date.AddDays(-1)

    while ($ExcludeDays -and $ExcludeDays -contains $date.DayOfWeek) {
        $date = $date.AddDays(-1)
    }

    return $date.Date
}
