BeforeAll {
    $TopLevel = Resolve-Path "$PSScriptRoot../../.."
    . $TopLevel\Source\Public\Get-NearestWeekday.ps1
}

Describe 'Get-NearestWeekday - Happy Path' {
    $testCases=@(
        @{ Year=2008; Month=11; Day=22; ExpectedDay=24 }
        @{ Year=2025; Month=3; Day=15; ExpectedDay=17 }

       )
    it 'Given Year=<Year>, Month=<Month>, should return the correct date' -ForEach $testCases {


        Get-NearestWeekday -Year $Year -Month $Month -Day $Day |
            Should -BeExactly (Get-Date -year $Year -Month $Month -Day $ExpectedDay).Date
    }
}

Describe 'Get-NearestWeekday - Before' {
    $testCases=@(
        @{ Year=2025; Month=3; Day=15; ExpectedDay=14 }

       )
    it 'Given Year=<Year>, Month=<Month>, should return the correct date' -ForEach $testCases {


        Get-NearestWeekday -Year $Year -Month $Month -Day $Day -Before |
            Should -BeExactly (Get-Date -year $Year -Month $Month -Day $ExpectedDay).Date
    }
}
