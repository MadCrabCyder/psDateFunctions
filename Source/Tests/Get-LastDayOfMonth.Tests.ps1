BeforeAll {
    $TopLevel = Resolve-Path "$PSScriptRoot../../.."
    . $TopLevel\Source\Public\Get-LastDayOfMonth.ps1
}

Describe 'Get-LastDayOfMonth - Happy Path' {
    it 'Should return the correct date' {


        $testCases=@(
            @{ Year=2008; Month=11; ExpectedDay=30 }
            @{ Year=2010; Month=4; ExpectedDay=30 }
            @{ Year=2013; Month=1; ExpectedDay=31 }
            @{ Year=2024; Month=2; ExpectedDay=29 }

        )

        foreach ($testCase in $testCases) {
            Get-LastDayOfMonth -Year $testCase.Year -Month $testCase.Month |
                Should -BeExactly (Get-Date -year $testCase.Year -Month $testCase.Month -Day $testCase.ExpectedDay).Date
        }
    }
}

Describe 'Get-LastDayOfMonth - Weekday' {
    it 'Should return the correct date' {


        $testCases=@(
            @{ Year=2025; Month=8; ExpectedDay=29 }
        )

        foreach ($testCase in $testCases) {
            Get-LastDayOfMonth -Year $testCase.Year -Month $testCase.Month -Weekday |
                Should -BeExactly (Get-Date -year $testCase.Year -Month $testCase.Month -Day $testCase.ExpectedDay).Date
        }
    }
}

Describe 'Get-LastDayOfMonth Exceptions' {
    Context 'Invalid Month' {
        $testCases=@(
            @{ Year=2023; Month=0 }
            @{ Year=2023; Month=-1 }
            @{ Year=2023; Month=13 }
            @{ Year=2023; Month=45 }
            @{ Year=2021; Month=-3 }
        )
        it 'Given an invalid month <Month>, should throw an exception' -ForEach $testCases {

            { Get-LastDayOfMonth -Month $Month -Year $Year } |
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

            { Get-LastDayOfMonth -Month $Month -Year $Year } |
                    Should -Throw 'Invalid Year'

        }
    }
}
