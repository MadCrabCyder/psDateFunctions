function Get-NthLastWeekdayOfMonth {
    [CmdletBinding()]
    [OutputType([System.DateTime])]
    param (
        [Parameter(Mandatory)][int]$Month,
        [Parameter(Mandatory)][int]$Year,
        [Parameter(Mandatory)][int]$Nth,
        [Parameter(Mandatory)][System.DayOfWeek]$WeekDay
    )

    if ($Month -lt 1 -or $month -gt 12) { throw 'Invalid Month'}

    $lastDayOfMonth = Get-LastDayOfMonth -Year $Year -Month $Month

    $result =  $lastDayOfMonth.AddDays(
        (
            ([System.DayOfWeek]::$WeekDay - $lastDayOfMonth.DayOfWeek -7 ) % -7
        ) - 7 * ($Nth -1)
    )

    if ($result.Month -ne $Month) { throw 'That day does not exist'}

    return $result
}
