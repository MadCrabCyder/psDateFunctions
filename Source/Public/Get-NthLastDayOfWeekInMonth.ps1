<#
.SYNOPSIS
Calculates and returns the Nth last occurrence of a specific DayOfWeek in a given month and year.

.DESCRIPTION
The Get-NthLastDayOfWeekInMonth function determines the Nth last occurrence of a specified DayOfWeek within a particular month and year. It is useful for finding specific DayOfWeeks for scheduling events, meetings, or for any scenario where the ordinal position of a DayOfWeek within a month is needed.

.PARAMETER Month
The numeric value representing the month. This parameter is mandatory and must be an integer between 1 (January) and 12 (December).

.PARAMETER Year
The numeric value representing the year. This parameter is mandatory and must be a integer between 1 and 9999.

.PARAMETER Nth
The ordinal instance of the DayOfWeek within the month. For example, 1 for the first occurrence, 2 for the second, etc. This parameter is mandatory and must be a positive integer between 1 and 5.

.PARAMETER DayOfWeek
The day of the week to find. This parameter is mandatory and accepts a [System.DayOfWeek] enum value (e.g., 'Sunday', 'Monday', 'Tuesday', etc.).

.EXAMPLE
Get-NthLastDayOfWeekInMonth -Month 3 -Year 2024 -Nth 2 -DayOfWeek 'Tuesday'

Returns the second last Tuesday of March 2024 as a System.DateTime object.

.EXAMPLE
$meetingDay = Get-NthLastDayOfWeekInMonth -Month 10 -Year 2023 -Nth 1 -DayOfWeek 'Monday'
Write-Output "The last Monday of October 2023 is on: $meetingDay"

Calculates the last Monday of October 2023, assigns it to the variable $meetingDay, and prints it.

.INPUTS
None. You cannot pipe objects to Get-NthLastDayOfWeekInMonth.

.OUTPUTS
System.DateTime
Returns a System.DateTime object representing the Nth occurrence of the specified DayOfWeek in the given month and year.

.NOTES
- Ensure the 'Month' and 'Year' parameters are within their valid ranges to avoid exceptions.
- The function will throw an exception if the calculated date does not exist within the specified month, e.g., seeking the 5th last occurrence of a day that only occurs 4 times in that month.
- The function will throw an exception of the Nth parameter is outside the range 1 to 5.

#>
function Get-NthLastDayOfWeekInMonth {
    [OutputType([System.DateTime])]
    param (
        [Parameter(Mandatory)][int]$Month,
        [Parameter(Mandatory)][int]$Year,
        [Parameter(Mandatory)][int]$Nth,
        [Parameter(Mandatory)][System.DayOfWeek]$DayOfWeek
    )

    if ($Month -lt 1 -or $Month -gt 12) { throw 'Invalid Month'}
    if ($Year -lt 1 -or $Year -gt 9999) { throw 'Invalid Year'}
    if ($Nth -lt 1 -or $Nth -gt 5) { throw 'Invalid Nth, must be between 1 and 5' }

    $lastDayInMonth = [datetime]::new($Year, $Month, [datetime]::DaysInMonth($Year, $Month))

    $result = $lastDayInMonth.AddDays(
        (
            ([int]$DayOfWeek - [int]$lastDayInMonth.DayOfWeek - 7) % -7
        ) - 7 * ($Nth -1)
    )

    if ($result.Month -ne $Month) { throw 'That day does not exist'}

    return $result
}
