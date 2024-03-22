<#
.SYNOPSIS
Calculates and returns the Nth occurrence of a specific weekday in a given month and year.

.DESCRIPTION
The Get-NthWeekdayOfMonth function determines the Nth occurrence of a specified weekday within a particular month and year. It is useful for finding specific weekdays for scheduling events, meetings, or for any scenario where the ordinal position of a weekday within a month is needed.

.PARAMETER Month
The numeric value representing the month. This parameter is mandatory and must be an integer between 1 (January) and 12 (December).

.PARAMETER Year
The numeric value representing the year. This parameter is mandatory and must be a integer between 1 and 9999.

.PARAMETER Nth
The ordinal instance of the weekday within the month. For example, 1 for the first occurrence, 2 for the second, etc. This parameter is mandatory and must be a positive integer between 1 and 5.

.PARAMETER WeekDay
The day of the week to find. This parameter is mandatory and accepts a [System.DayOfWeek] enum value (e.g., 'Sunday', 'Monday', 'Tuesday', etc.).

.EXAMPLE
Get-NthWeekdayOfMonth -Month 3 -Year 2024 -Nth 2 -WeekDay 'Tuesday'

Returns the second Tuesday of March 2024 as a System.DateTime object.

.EXAMPLE
$meetingDay = Get-NthWeekdayOfMonth -Month 10 -Year 2023 -Nth 1 -WeekDay 'Monday'
Write-Output "The first Monday of October 2023 is on: $meetingDay"

Calculates the first Monday of October 2023, assigns it to the variable $meetingDay, and prints it.

.INPUTS
None. You cannot pipe objects to Get-NthWeekdayOfMonth.

.OUTPUTS
System.DateTime
Returns a System.DateTime object representing the Nth occurrence of the specified weekday in the given month and year.

.NOTES
- Ensure the 'Month' and 'Year' parameters are within their valid ranges to avoid exceptions.
- The function will throw an exception if the calculated date does not exist within the specified month, e.g., seeking the 5th occurrence of a day that only occurs 4 times in that month.
- The function will throw an exception of the Nth parameter is outside the range 1 to 5.

#>
function Get-NthWeekdayOfMonth {
    [OutputType([System.DateTime])]
    param (
        [Parameter(Mandatory)][int]$Month,
        [Parameter(Mandatory)][int]$Year,
        [Parameter(Mandatory)][int]$Nth,
        [Parameter(Mandatory)][System.DayOfWeek]$WeekDay
    )

    if ($Month -lt 1 -or $Month -gt 12) { throw 'Invalid Month'}
    if ($Year -lt 1 -or $Year -gt 9999) { throw 'Invalid Year'}
    if ($Nth -lt 1 -or $Nth -gt 5) { throw 'Invalid Nth, must be between 1 and 5' }

    $firstDayOfMonth = Get-1stDayOfMonth -Year $Year -Month $Month

    $result =  $firstDayOfMonth.AddDays(
        (
            (7 + [System.DayOfWeek]::$WeekDay - $firstDayOfMonth.DayOfWeek) % 7
        ) + 7 * ($Nth -1)
    )

    if ($result.Month -ne $Month) { throw 'That day does not exist'}

    return $result
}
