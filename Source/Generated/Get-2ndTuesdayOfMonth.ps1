function Get-2ndTuesdayOfMonth {
    [Alias('Get-PatchTuesday')]
    [CmdletBinding()]
    [OutputType([System.DateTime])]
    param (
        [Parameter(Mandatory)][int]$Month,
        [Parameter(Mandatory)][int]$Year
    )
    Get-NthWeekdayOfMonth -Year $Year -Month $Month -WeekDay Tuesday -Nth 2
}
