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

.PARAMETER Date
An optional date used to determine the target month and year. Defaults to today's date when no parameters are supplied.

.EXAMPLE
Get-PatchTuesday -Month 9 -Year 2024

Returns the Patch Tuesday date (2nd Tuesday) of September 2024.

.EXAMPLE
$patchDay = Get-PatchTuesday -Month 3 -Year 2025
Write-Output "Patch Tuesday in March 2025 falls on: $patchDay"

Calculates the Patch Tuesday date for March 2025 and outputs it.

.EXAMPLE
Get-PatchTuesday -Date (Get-Date '2025-03-15')

Returns the Patch Tuesday date for the month and year of the supplied date.

.EXAMPLE
Get-PatchTuesday

Returns the Patch Tuesday date for the current month.

.EXAMPLE
Get-Date '2025-03-15' | Get-PatchTuesday

Returns the Patch Tuesday date for the month and year of the piped input date.

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
    [CmdletBinding(DefaultParameterSetName='Date')]
    [OutputType([datetime])]
    param (
        [Parameter(Mandatory, ParameterSetName='MonthYear', HelpMessage='Enter the month number, from 1 to 12.')]
        [ValidateRange(1,12)]
        [int]$Month,

        [Parameter(Mandatory, ParameterSetName='MonthYear', HelpMessage='Enter the year, from 1 to 9999.')]
        [ValidateRange(1,9999)]
        [int]$Year,

        [Parameter(ParameterSetName='Date', ValueFromPipeline, HelpMessage='Enter any date in the target month, or omit it to use today.')]
        [datetime]$Date = [datetime]::Today
    )

    process {
        if ($PSCmdlet.ParameterSetName -eq 'Date') {
            $Month = $Date.Month
            $Year = $Date.Year
        }

        $firstDayInMonth = [datetime]::new($Year, $Month, 1)

        # Patch Tuesday is always the second Tuesday of the month, so it must fall
        # between the 8th and the 14th.

        # First calculate the offset from the 1st of the month to the first Tuesday.
        # The modulo keeps the result in the range 0..6 even when the month starts after Tuesday.
        # Then add 8 to move to the day-of-month for the second Tuesday.

        $day = 8 + ((7 + [int][System.DayOfWeek]::Tuesday - [int]$firstDayInMonth.DayOfWeek) % 7)

        return [datetime]::new($Year, $Month, $day)
    }
}
