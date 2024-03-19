function Get-FirstDayOfMonth {
    [CmdletBinding()]
    [OutputType([System.DateTime])]
    param (
        [Parameter(Mandatory)][int]$Month,
        [Parameter(Mandatory)][int]$Year
    )
    if ($Month -lt 1 -or $month -gt 12) { throw 'Invalid Month'}
    return (Get-Date -Year $Year -Month $Month -Day 1).Date
}
