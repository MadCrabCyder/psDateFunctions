BeforeAll {
    $TopLevel = Resolve-Path "$PSScriptRoot../../.."

    . $TopLevel\Source\Public\Get-1stWeekdayInMonth.ps1
    . $TopLevel\Source\Public\Get-1stDayInMonth.ps1
}

# Requires -Version 5.0
Describe 'Get-1stWeekdayInMonth' {

    BeforeEach {
        Mock -CommandName Get-1stDayInMonth {
            return [datetime]'2026-01-01'
        }
    }

    $testCases = @(
        @{ Month = 1; Year = 2026; ExcludeDays = $null},
        @{ Month = 3; Year = 2025; ExcludeDays = @([DayOfWeek]::Sunday); },
        @{ Month = 12; Year = 2024; ExcludeDays = @([DayOfWeek]::Friday, [DayOfWeek]::Saturday) }
    )

    it 'Given Year=<Year>, Month=<Month>, ExcludeDays="<ExcludeDays>" should call Get-1stDayInMonth with correct params' -ForEach $testCases {

        # Act
        Get-1stWeekdayInMonth -Month $Month -Year $Year -ExcludeDays:$ExcludeDays

        $expectedMonth = $Month
        $expectedYear = $Year
        $expectedExclude = $ExcludeDays

        # Assert
        Assert-MockCalled -CommandName Get-1stDayInMonth -Exactly 1  -Scope It -ParameterFilter {
             $Month -eq $expectedMonth -and
             $Year -eq $expectedYear -and
             $Weekday -eq $true -and
            (
                ($null -eq $expectedExclude -and $null -eq $ExcludeDays) -or
                ($ExcludeDays -join ',' -eq $expectedExclude -join ',')
            )
        }
    }
}

