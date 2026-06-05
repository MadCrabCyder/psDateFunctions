<#
.SYNOPSIS
Calculates the date of Patch Tuesday for a specified month and year.

.DESCRIPTION
The Get-PatchTuesday function returns the date of Microsoft's Patch Tuesday, which occurs on the 2nd Tuesday of each month. This function is helpful for IT administrators, DevOps engineers, and security teams who need to plan or automate around Windows update schedules.

Rather than looping day by day until Tuesday is found, this implementation calculates the required offset directly from the 1st day of the month using DayOfWeek arithmetic.

Patch Tuesday is commonly used as a recurring event for system patching, update validation, and reporting processes.

.PARAMETER Month
The numeric value representing the month. This parameter is mandatory and must be an integer between 1 (January) and 12 (December).

.PARAMETER Year
The numeric value representing the year. This parameter is mandatory and must be an integer between 1 and 9999.

.EXAMPLE
Get-PatchTuesday -Month 9 -Year 2024

Returns the Patch Tuesday date (2nd Tuesday) of September 2024.

.EXAMPLE
$patchDay = Get-PatchTuesday -Month 3 -Year 2025
Write-Output "Patch Tuesday in March 2025 falls on: $patchDay"

Calculates the Patch Tuesday date for March 2025 and outputs it.

.INPUTS
None. You cannot pipe input to Get-PatchTuesday.

.OUTPUTS
System.DateTime
Returns a System.DateTime object representing the Patch Tuesday (2nd Tuesday) of the given month and year.

.NOTES
See the full module to see how this logic can be extended to cover all variations of the nth instance, or nth last instance of a particular DayOfWeek in a month:
https://github.com/MadCrabCyder/psDateFunctions

#>
function Get-PatchTuesday {
    [OutputType([datetime])]
    param (
        [Parameter(Mandatory)][int]$Month,
        [Parameter(Mandatory)][int]$Year
    )

    if ($Month -lt 1 -or $Month -gt 12) { throw 'Invalid Month'}
    if ($Year -lt 1 -or $Year -gt 9999) { throw 'Invalid Year'}


    $firstDayInMonth = [datetime]::new($Year, $Month, 1)

    # First, calculate how many days from the 1st of the month to the first Tuesday.
    # The modulo keeps the result in the range 0..6 even when the month starts after Tuesday.
    # Then add 7 more days to move from the first Tuesday to the second Tuesday.
    $offset = ((7 + [int][System.DayOfWeek]::Tuesday - [int]$firstDayInMonth.DayOfWeek) % 7) + 7

    return $firstDayInMonth.AddDays($offset)

}
