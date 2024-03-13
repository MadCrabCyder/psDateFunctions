function Get-4thFridayOfMonth {
    [Alias('')]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][int]$Month,
        [Parameter(Mandatory)][int]$Year
    )
    Get-NthWeekdayOfMonth -Year $Year -Month $Month -WeekDay Friday -Nth 4
}
