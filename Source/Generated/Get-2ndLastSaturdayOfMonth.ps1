function Get-2ndLastSaturdayOfMonth {
    [Alias('')]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][int]$Month,
        [Parameter(Mandatory)][int]$Year
    )
    Get-NthLastWeekdayOfMonth -Year $Year -Month $Month -WeekDay Saturday -Nth 2
}
