function Get-2ndLastThursdayOfMonth {
    [Alias('')]
    [CmdletBinding()]
    [OutputType([System.DateTime])]
    param (
        [Parameter(Mandatory)][int]$Month,
        [Parameter(Mandatory)][int]$Year
    )
    Get-NthLastWeekdayOfMonth -Year $Year -Month $Month -WeekDay Thursday -Nth 2
}
