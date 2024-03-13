function Get-NthWeekdayOfMonth {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][int]$Month,
        [Parameter(Mandatory)][int]$Year,
        [Parameter(Mandatory)][int]$Nth,
        [Parameter(Mandatory)][System.DayOfWeek]$WeekDay
    )

    if ($Month -lt 1 -or $month -gt 12) { throw 'Invalid Month'}

    $firstDayOfMonth = Get-FirstDayOfMonth -Year $Year -Month $Month

    $result =  $firstDayOfMonth.AddDays(
        (
            (7 + [System.DayOfWeek]::$WeekDay - $firstDayOfMonth.DayOfWeek) % 7
        ) + 7 * ($Nth -1)
    )

    if ($result.Month -ne $Month) { throw 'That day does not exist'}

    return $result
}
