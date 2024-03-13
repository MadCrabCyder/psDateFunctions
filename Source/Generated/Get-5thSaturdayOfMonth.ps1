function Get-5thSaturdayOfMonth {
    [Alias('')]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][int]$Month,
        [Parameter(Mandatory)][int]$Year
    )
    Get-NthWeekdayOfMonth -Year $Year -Month $Month -WeekDay Saturday -Nth 5
}
