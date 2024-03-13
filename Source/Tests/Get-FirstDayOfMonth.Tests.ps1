BeforeAll {
    $TopLevel = (Split-Path(Split-Path $PSScriptRoot))
    . $TopLevel\Source\Public\Get-FirstDayOfMonth.ps1
}

Describe 'Get-FirstDayOfMonth - Happy Path' {
    it 'Should return the correct date' {

        $testCases=@(
            @{ Year=2008; Month=11; ExpectedDay=1 }
            @{ Year=2010; Month=4; ExpectedDay=1 }
            @{ Year=2013; Month=1; ExpectedDay=1 }
            @{ Year=2005; Month=11; ExpectedDay=1 }
           )

        foreach ($testCase in $testCases) {


            Get-FirstDayOfMonth -Year $testCase.Year -Month $testCase.Month |
                Should -BeExactly (Get-Date -year $testCase.Year -Month $testCase.Month -Day $testCase.ExpectedDay).Date
        }
    }
}

Describe 'Get-FirstDayOfMonth Exceptions' {
    it 'Given an invalid month, should throw an exception' {
        $testCases=@(
                @{ Year=2023; Month=0 }
                @{ Year=2023; Month=-1 }
                @{ Year=2023; Month=13 }
                @{ Year=2023; Month=45 }
                @{ Year=2021; Month=-3 }
        )
        foreach ($testCase in $testCases) {
            { Get-FirstDayOfMonth -Month $testCase.Month -Year $testCase.Year } |
                Should -Throw 'Invalid Month'
        }
    }
}

