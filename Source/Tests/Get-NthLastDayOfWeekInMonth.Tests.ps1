BeforeAll {
    $TopLevel = Resolve-Path "$PSScriptRoot../../.."
    . $TopLevel\Source\Public\Get-LastDayInMonth.ps1
    . $TopLevel\Source\Public\Get-NthLastDayOfWeekInMonth.ps1
}

Describe 'Get-NthLastDayOfWeekInMonth - Happy Path' {
    $testCases=@(
        @{ Year=2008; Month=11; Weekday=[System.DayOfWeek]::Saturday; Nth=1; ExpectedDay=29 }
        @{ Year=2010; Month=4; Weekday=[System.DayOfWeek]::Monday; Nth=1; ExpectedDay=26 }
        @{ Year=2013; Month=1; Weekday=[System.DayOfWeek]::Monday; Nth=2; ExpectedDay=21 }
        @{ Year=2005; Month=11; Weekday=[System.DayOfWeek]::Sunday; Nth=3; ExpectedDay=13 }
        @{ Year=1985; Month=8; Weekday=[System.DayOfWeek]::Sunday; Nth=1; ExpectedDay=25 }
        @{ Year=1984; Month=1; Weekday=[System.DayOfWeek]::Thursday; Nth=3; ExpectedDay=12 }
        @{ Year=2008; Month=5; Weekday=[System.DayOfWeek]::Thursday; Nth=5; ExpectedDay=1 }
        @{ Year=2020; Month=10; Weekday=[System.DayOfWeek]::Wednesday; Nth=3; ExpectedDay=14 }
        @{ Year=1996; Month=6; Weekday=[System.DayOfWeek]::Friday; Nth=3; ExpectedDay=14 }
        @{ Year=1983; Month=4; Weekday=[System.DayOfWeek]::Friday; Nth=2; ExpectedDay=22 }
        @{ Year=2007; Month=4; Weekday=[System.DayOfWeek]::Monday; Nth=5; ExpectedDay=2}
    )

    it 'Given Year=<Year>, Month=<Month>, DayOfWeek=<Weekday>, Nth=<Nth>, should return the correct date' -ForEach $testCases {
        Get-NthLastDayOfWeekInMonth -Year $Year -Month $Month -DayOfWeek $Weekday -Nth $Nth |
            Should -BeExactly (Get-Date -year $Year -Month $Month -Day $ExpectedDay).Date
    }
}

Describe 'Get-NthLastDayOfWeekInMonth Exceptions' {
    $invalidMonthCases=@(
        @{ Year=2023; Month=0; Weekday=[System.DayOfWeek]::Saturday; Nth=3 }
        @{ Year=2023; Month=-1; Weekday=[System.DayOfWeek]::Sunday; Nth=1 }
        @{ Year=2023; Month=13; Weekday=[System.DayOfWeek]::Friday; Nth=3 }
        @{ Year=2023; Month=45; Weekday=[System.DayOfWeek]::Thursday; Nth=3 }
        @{ Year=2021; Month=-3; Weekday=[System.DayOfWeek]::Wednesday; Nth=1}
    )
    it 'Given invalid Month=<Month>, should throw an exception' -ForEach $invalidMonthCases {
        { Get-NthLastDayOfWeekInMonth -Month $Month -Year $Year -DayOfWeek $Weekday -Nth $Nth } |
            Should -Throw 'Invalid Month'
    }

    $invalidNthCases=@(
        @{ Year=2023; Month=1; Weekday=[System.DayOfWeek]::Saturday; Nth=0 }
        @{ Year=2023; Month=2; Weekday=[System.DayOfWeek]::Sunday; Nth=-1 }
        @{ Year=2023; Month=3; Weekday=[System.DayOfWeek]::Friday; Nth=6 }
        @{ Year=2023; Month=4; Weekday=[System.DayOfWeek]::Thursday; Nth=25 }
        @{ Year=2021; Month=5; Weekday=[System.DayOfWeek]::Wednesday; Nth=-16}
    )
    it 'Given invalid Nth=<Nth>, should throw an exception' -ForEach $invalidNthCases {
        { Get-NthLastDayOfWeekInMonth -Month $Month -Year $Year -DayOfWeek $Weekday -Nth $Nth } |
            Should -Throw 'Invalid Nth, must be between 1 and 5'
    }

    $invalidYearCases=@(
        @{ Year=0; Month=1; Weekday=[System.DayOfWeek]::Saturday; Nth=3 }
        @{ Year=10000; Month=2; Weekday=[System.DayOfWeek]::Sunday; Nth=1 }
        @{ Year=-1; Month=3; Weekday=[System.DayOfWeek]::Friday; Nth=3 }
        @{ Year=-5; Month=4; Weekday=[System.DayOfWeek]::Thursday; Nth=3 }
    )
    it 'Given invalid Year=<Year>, should throw an exception' -ForEach $invalidYearCases {
        { Get-NthLastDayOfWeekInMonth -Month $Month -Year $Year -DayOfWeek $Weekday -Nth $Nth } |
            Should -Throw 'Invalid Year'
    }

    $missingDayCases=@(
            @{ Year=2020; Month=8; Weekday=[System.DayOfWeek]::Tuesday; Nth=5}
            @{ Year=1995; Month=2; Weekday=[System.DayOfWeek]::Friday; Nth=5}
            @{ Year=2007; Month=4; Weekday=[System.DayOfWeek]::Friday; Nth=5}
            @{ Year=2013; Month=4; Weekday=[System.DayOfWeek]::Friday; Nth=5}
            @{ Year=2022; Month=7; Weekday=[System.DayOfWeek]::Wednesday; Nth=5}
    )
    it 'Given Month=<Month>, Year=<Year>, DayOfWeek=<Weekday>, Nth=<Nth>, should throw when the day does not exist' -ForEach $missingDayCases {
        {
            Get-NthLastDayOfWeekInMonth -Month $Month -Year $Year -DayOfWeek $Weekday -Nth $Nth
        } | Should -Throw 'That day does not exist'
    }


}
