BeforeAll {
    $TopLevel = Resolve-Path "$PSScriptRoot../../.."
    . $TopLevel\Source\Public\Get-LastDayInMonth.ps1
}

Describe 'Get-LastDayInMonth - Happy Path' {
    $testCases=@(
        @{ Year=2008; Month=11; ExpectedDay=30 }
        @{ Year=2010; Month=4; ExpectedDay=30 }
        @{ Year=2013; Month=1; ExpectedDay=31 }
        @{ Year=2024; Month=2; ExpectedDay=29 }
    )

    it 'Given Year=<Year>, Month=<Month>, should return the correct date' -ForEach $testCases {
        Get-LastDayInMonth -Year $Year -Month $Month |
            Should -BeExactly (Get-Date -year $Year -Month $Month -Day $ExpectedDay).Date
    }
}

Describe 'Get-LastDayInMonth - Weekday' {
    $testCases=@(
        @{ Year=2025; Month=8; ExpectedDay=29 }
    )

    it 'Given Year=<Year>, Month=<Month>, should return the correct weekday date' -ForEach $testCases {
        Get-LastDayInMonth -Year $Year -Month $Month -Weekday |
            Should -BeExactly (Get-Date -year $Year -Month $Month -Day $ExpectedDay).Date
    }
}

Describe 'Get-LastDayInMonth Exceptions' {
    Context 'Invalid Month' {
        $testCases=@(
            @{ Year=2023; Month=0 }
            @{ Year=2023; Month=-1 }
            @{ Year=2023; Month=13 }
            @{ Year=2023; Month=45 }
            @{ Year=2021; Month=-3 }
        )
        it 'Given an invalid month <Month>, should throw an exception' -ForEach $testCases {

            { Get-LastDayInMonth -Month $Month -Year $Year } |
                    Should -Throw 'Invalid Month'

        }
    }

    Context 'Invalid Year' {
        $testCases=@(
            @{ Year=0; Month=1 }
            @{ Year=10000; Month=1 }
            @{ Year=-5; Month=1 }

        )
        it 'Given an invalid Year <Year>, should throw an exception' -ForEach $testCases {

            { Get-LastDayInMonth -Month $Month -Year $Year } |
                    Should -Throw 'Invalid Year'

        }
    }
}
