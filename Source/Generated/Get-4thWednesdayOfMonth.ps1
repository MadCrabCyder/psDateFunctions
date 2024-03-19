function Get-4thWednesdayOfMonth {
    [Alias('')]
    [CmdletBinding()]
    [OutputType([System.DateTime])]
    param (
        [Parameter(Mandatory)][int]$Month,
        [Parameter(Mandatory)][int]$Year
    )
    Get-NthWeekdayOfMonth -Year $Year -Month $Month -WeekDay Wednesday -Nth 4
}
