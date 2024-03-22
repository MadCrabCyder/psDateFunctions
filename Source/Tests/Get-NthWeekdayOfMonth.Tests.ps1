BeforeAll {
    $TopLevel = Resolve-Path "$PSScriptRoot../../.."
    . $TopLevel\Source\Public\Get-1stDayOfMonth.ps1
    . $TopLevel\Source\Public\Get-NthWeekdayOfMonth.ps1
}

Describe 'Get-NthWeekdayOfMonth - Happy Path' {
    it 'Should return the correct date' {
        $common=@{Hour=0; Minute=0; Second=0; Millisecond=0}

        $testCases=@(
            @{ Year=2008; Month=11; Weekday=[System.DayOfWeek]::Saturday; Nth=3; ExpectedDay=15 }
            @{ Year=2010; Month=4; Weekday=[System.DayOfWeek]::Monday; Nth=1; ExpectedDay=5 }
            @{ Year=2013; Month=1; Weekday=[System.DayOfWeek]::Monday; Nth=4; ExpectedDay=28 }
            @{ Year=2005; Month=11; Weekday=[System.DayOfWeek]::Sunday; Nth=1; ExpectedDay=6 }
            @{ Year=1985; Month=8; Weekday=[System.DayOfWeek]::Sunday; Nth=1; ExpectedDay=4 }
            @{ Year=1984; Month=1; Weekday=[System.DayOfWeek]::Thursday; Nth=3; ExpectedDay=19 }
            @{ Year=2008; Month=5; Weekday=[System.DayOfWeek]::Thursday; Nth=5; ExpectedDay=29 }
            @{ Year=2020; Month=10; Weekday=[System.DayOfWeek]::Wednesday; Nth=3; ExpectedDay=21 }
            @{ Year=1996; Month=6; Weekday=[System.DayOfWeek]::Friday; Nth=3; ExpectedDay=21 }
            @{ Year=1983; Month=4; Weekday=[System.DayOfWeek]::Friday; Nth=2; ExpectedDay=8 }
            @{ Year=2007; Month=4; Weekday=[System.DayOfWeek]::Monday; Nth=5; ExpectedDay=30}
        )

        foreach ($testCase in $testCases) {
            Get-NthWeekdayOfMonth -Year $testCase.Year -Month $testCase.Month -WeekDay $testCase.Weekday -Nth $testCase.Nth|
                Should -BeExactly (Get-Date -year $testCase.Year -Month $testCase.Month -Day $testCase.ExpectedDay @common)
        }
    }
}

Describe 'Get-NthWeekdayOfMonth Exceptions' {
    it 'Given an invalid month, should throw an exception' {
        $testCases=@(
                @{ Year=2023; Month=0; Weekday=[System.DayOfWeek]::Saturday; Nth=3 }
                @{ Year=2023; Month=-1; Weekday=[System.DayOfWeek]::Sunday; Nth=1 }
                @{ Year=2023; Month=13; Weekday=[System.DayOfWeek]::Friday; Nth=3 }
                @{ Year=2023; Month=45; Weekday=[System.DayOfWeek]::Thursday; Nth=3 }
                @{ Year=2021; Month=-3; Weekday=[System.DayOfWeek]::Wednesday; Nth=1}
        )
        foreach ($testCase in $testCases) {
            { Get-NthWeekdayOfMonth -Month $testCase.Month -Year $testCase.Year -WeekDay $testCase.Weekday -Nth $testCase.Nth } |
                Should -Throw 'Invalid Month'
        }
    }

    it 'Given an invalid year, should throw an exception' {
        $testCases=@(
                @{ Year=0; Month=1; Weekday=[System.DayOfWeek]::Saturday; Nth=3 }
                @{ Year=10000; Month=2; Weekday=[System.DayOfWeek]::Sunday; Nth=1 }
                @{ Year=-1; Month=3; Weekday=[System.DayOfWeek]::Friday; Nth=3 }
                @{ Year=-5; Month=4; Weekday=[System.DayOfWeek]::Thursday; Nth=3 }
        )
        foreach ($testCase in $testCases) {
            { Get-NthWeekdayOfMonth -Month $testCase.Month -Year $testCase.Year -WeekDay $testCase.Weekday -Nth $testCase.Nth } |
                Should -Throw 'Invalid Year'
        }
    }

    it 'Given an invalid Nth, should throw an exception' {
        $testCases=@(
                @{ Year=2023; Month=1; Weekday=[System.DayOfWeek]::Saturday; Nth=0 }
                @{ Year=2023; Month=2; Weekday=[System.DayOfWeek]::Sunday; Nth=-1 }
                @{ Year=2023; Month=3; Weekday=[System.DayOfWeek]::Friday; Nth=6 }
                @{ Year=2023; Month=4; Weekday=[System.DayOfWeek]::Thursday; Nth=25 }
                @{ Year=2021; Month=5; Weekday=[System.DayOfWeek]::Wednesday; Nth=-16}
        )
        foreach ($testCase in $testCases) {
            { Get-NthWeekdayOfMonth -Month $testCase.Month -Year $testCase.Year -WeekDay $testCase.Weekday -Nth $testCase.Nth } |
                Should -Throw 'Invalid Nth, must be between 1 and 5'
        }
    }

    it 'Requesting a 5th day, should throw an exception, if it is not in the same month' {
        $testCases=@(
            @{ Year=2020; Month=8; Weekday=[System.DayOfWeek]::Tuesday; Nth=5}
            @{ Year=1995; Month=2; Weekday=[System.DayOfWeek]::Friday; Nth=5}
            @{ Year=2007; Month=4; Weekday=[System.DayOfWeek]::Friday; Nth=5}
            @{ Year=2013; Month=4; Weekday=[System.DayOfWeek]::Friday; Nth=5}
            @{ Year=2022; Month=7; Weekday=[System.DayOfWeek]::Wednesday; Nth=5}
        )
        foreach ($testCase in $testCases) {
            { Get-NthWeekdayOfMonth -Month $testCase.Month -Year $testCase.Year -WeekDay $testCase.Weekday -Nth $testCase.Nth } |
                Should -Throw 'That day does not exist'
        }
    }


}
