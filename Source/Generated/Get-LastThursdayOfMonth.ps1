function Get-LastThursdayOfMonth {
    [Alias('')]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][int]$Month,
        [Parameter(Mandatory)][int]$Year
    )
    Get-NthLastWeekdayOfMonth -Year $Year -Month $Month -WeekDay Thursday -Nth 1
}
