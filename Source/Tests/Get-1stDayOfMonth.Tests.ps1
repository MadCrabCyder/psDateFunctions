BeforeAll {
    $TopLevel = Resolve-Path "$PSScriptRoot../../.."
    . $TopLevel\Source\Public\Get-1stDayOfMonth.ps1
}

Describe 'Get-1stDayOfMonth - Happy Path' {
    $testCases=@(
        @{ Year=2008; Month=11; ExpectedDay=1 }
        @{ Year=2010; Month=4; ExpectedDay=1 }
        @{ Year=2013; Month=1; ExpectedDay=1 }
        @{ Year=2005; Month=11; ExpectedDay=1 }
       )
    it 'Given Year=<Year>, Month=<Month>, should return the correct date' -ForEach $testCases {


        Get-1stDayOfMonth -Year $Year -Month $Month |
            Should -BeExactly (Get-Date -year $Year -Month $Month -Day $ExpectedDay).Date
    }
}

Describe 'Get-1stDayOfMonth Exceptions' {
    Context 'Invalid Month' {
        $testCases=@(
            @{ Year=2023; Month=0 }
            @{ Year=2023; Month=-1 }
            @{ Year=2023; Month=13 }
            @{ Year=2023; Month=45 }
            @{ Year=2021; Month=-3 }
        )
        it 'Given an invalid month <Month>, should throw an exception' -ForEach $testCases {

            { Get-1stDayOfMonth -Month $Month -Year $Year } |
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

            { Get-1stDayOfMonth -Month $Month -Year $Year } |
                    Should -Throw 'Invalid Year'

        }
    }
}
