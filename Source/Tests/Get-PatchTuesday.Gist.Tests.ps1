BeforeAll {
    $TopLevel = Resolve-Path "$PSScriptRoot../../.."

    . $TopLevel\Source\Gist\Get-PatchTuesday.ps1
}

Describe 'Get-PatchTuesday Gist - Happy Path' {
    $testCases = @(
        @{ Month = 1; Year = 2026; ExpectedDay = 13 }
        @{ Month = 3; Year = 2025; ExpectedDay = 11 }
        @{ Month = 12; Year = 2024; ExpectedDay = 10 }
        @{ Month = 9; Year = 2024; ExpectedDay = 10 }
        @{ Month = 2; Year = 2024; ExpectedDay = 13 }
    )

    it 'Given Year=<Year>, Month=<Month>, should return the Patch Tuesday date' -ForEach $testCases {
        Get-PatchTuesday -Month $Month -Year $Year |
            Should -BeExactly ([datetime]::new($Year, $Month, $ExpectedDay))
    }

    $dateCases = @(
        @{ Date = [datetime]'2025-03-15'; Expected = [datetime]'2025-03-11' }
        @{ Date = [datetime]'2024-09-30'; Expected = [datetime]'2024-09-10' }
        @{ Date = [datetime]'2026-01-01'; Expected = [datetime]'2026-01-13' }
    )

    it 'Given Date=<Date>, should return the Patch Tuesday date for that month' -ForEach $dateCases {
        Get-PatchTuesday -Date $Date |
            Should -BeExactly $Expected
    }

    it 'With no parameters, should return the Patch Tuesday date for the current month' {
        $today = [datetime]::Today
        $firstDayInMonth = [datetime]::new($today.Year, $today.Month, 1)
        $offset = ((7 + [int][System.DayOfWeek]::Tuesday - [int]$firstDayInMonth.DayOfWeek) % 7) + 7
        $expected = $firstDayInMonth.AddDays($offset)

        Get-PatchTuesday |
            Should -BeExactly $expected
    }
}

Describe 'Get-PatchTuesday Gist - Exceptions' {
    $invalidMonthCases = @(
        @{ Year = 2026; Month = 0 }
        @{ Year = 2026; Month = -1 }
        @{ Year = 2026; Month = 13 }
        @{ Year = 2026; Month = 99 }
    )

    it 'Given invalid Month=<Month>, should fail parameter validation' -ForEach $invalidMonthCases {
        { Get-PatchTuesday -Month $Month -Year $Year } |
            Should -Throw
    }

    $invalidYearCases = @(
        @{ Year = 0; Month = 1 }
        @{ Year = -1; Month = 1 }
        @{ Year = 10000; Month = 1 }
    )

    it 'Given invalid Year=<Year>, should fail parameter validation' -ForEach $invalidYearCases {
        { Get-PatchTuesday -Month $Month -Year $Year } |
            Should -Throw
    }
}
