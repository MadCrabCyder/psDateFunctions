function Get-1stSundayOfMonth {
    [Alias('')]
    [CmdletBinding()]
    [OutputType([System.DateTime])]
    param (
        [Parameter(Mandatory)][int]$Month,
        [Parameter(Mandatory)][int]$Year
    )
    Get-NthWeekdayOfMonth -Year $Year -Month $Month -WeekDay Sunday -Nth 1
}
