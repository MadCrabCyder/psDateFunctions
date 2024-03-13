function Get-2ndLastTuesdayOfMonth {
    [Alias('Get-PatchTuesday')]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][int]$Month,
        [Parameter(Mandatory)][int]$Year
    )
    Get-NthLastWeekdayOfMonth -Year $Year -Month $Month -WeekDay Tuesday -Nth 2
}
