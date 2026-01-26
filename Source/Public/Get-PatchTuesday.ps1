<#
.SYNOPSIS
Calculates the date of Patch Tuesday for a specified month and year.

.DESCRIPTION
The Get-PatchTuesday function returns the date of Microsoft's Patch Tuesday, which occurs on the 2nd Tuesday of each month. This function is helpful for IT administrators, DevOps engineers, and security teams who need to plan or automate around Windows update schedules.

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
This function wraps Get-2ndTuesdayInMonth, providing a semantic and discoverable entry point for retrieving Patch Tuesday dates in scripts or tooling.

#>
function Get-PatchTuesday {
    [OutputType([datetime])]
    param (
        [Parameter(Mandatory)][int]$Month,
        [Parameter(Mandatory)][int]$Year
    )

    Get-2ndTuesdayInMonth -Month $Month -Year $Year
}
