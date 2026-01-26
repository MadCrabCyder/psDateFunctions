<#
.SYNOPSIS
Returns the nearest valid Weekday for a specified date.

.DESCRIPTION
The Get-NearestWeekday function returns a System.DateTime representing the nearest valid Weekday (Monday–Friday by default), based on a provided year, month, and day.
You can exclude specific days of the week (e.g., weekends or holidays) and choose whether to search forward (default) or backward (using the -Before switch).

.PARAMETER Year
The year component of the input date. Must be between 1 and 9999.

.PARAMETER Month
The month component of the input date. Must be between 1 and 12.

.PARAMETER Day
The day component of the input date. Must be valid for the given month and year.

.PARAMETER Before
If specified, the function searches for the nearest valid Weekday **before** the given date.
If not specified, the function searches **after** the given date.

.PARAMETER ExcludeDays
Optional. An array of [System.DayOfWeek] values to exclude when determining the nearest Weekday.
Defaults to Saturday and Sunday. You can specify other days (e.g., Friday) or none at all.

.EXAMPLE
Get-NearestWeekday -Year 2025 -Month 3 -Day 15

Returns the next valid Weekday after March 15, 2025 (Saturday), which is Monday, March 17.

.EXAMPLE
Get-NearestWeekday -Year 2025 -Month 3 -Day 15 -Before

Returns the previous valid Weekday before March 15, 2025 (Saturday), which is Friday, March 14.

.EXAMPLE
Get-NearestWeekday -Year 2025 -Month 3 -Day 12 -ExcludeDays Wednesday, Saturday, Sunday -Before

Returns the previous Weekday that is not Wednesday, Saturday, or Sunday before March 12, 2025.

.INPUTS
None. You cannot pipe input into this function.

.OUTPUTS
System.DateTime. The adjusted Weekday based on the input date and filtering options.

.NOTES
The function performs strict validation on year, month, and day ranges.
If the provided date is not excluded, it is returned as-is.
Use this function to normalize a date to your business calendar rules.
#>
function Get-NearestWeekday {
    [OutputType([datetime])]
    param (
        [Parameter(Mandatory)][int]$Year,
        [Parameter(Mandatory)][int]$Month,
        [Parameter(Mandatory)][int]$Day,
        [switch]$Before,
        [DayOfWeek[]]$ExcludeDays = @([DayOfWeek]::Saturday, [DayOfWeek]::Sunday)
    )

    if ($Month -lt 1 -or $Month -gt 12) { throw 'Invalid Month' }
    if ($Year -lt 1 -or $Year -gt 9999) { throw 'Invalid Year' }
    if ($Day -lt 1 -or $Day -gt ([DateTime]::DaysInMonth($Year, $Month))) { throw 'Invalid Day' }

    $date = Get-Date -Year $Year -Month $Month -Day $Day

    while ($ExcludeDays -contains $date.DayOfWeek) {
        $date = if ($Before) { $date.AddDays(-1) } else { $date.AddDays(1) }
    }

    return $date.Date
}
