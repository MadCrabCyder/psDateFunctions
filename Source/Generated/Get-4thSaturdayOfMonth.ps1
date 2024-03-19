function Get-4thSaturdayOfMonth {
    [Alias('')]
    [CmdletBinding()]
    [OutputType([System.DateTime])]
    param (
        [Parameter(Mandatory)][int]$Month,
        [Parameter(Mandatory)][int]$Year
    )
    Get-NthWeekdayOfMonth -Year $Year -Month $Month -WeekDay Saturday -Nth 4
}
