BeforeAll {
    $TopLevel = (Split-Path(Split-Path $PSScriptRoot))
    . $TopLevel\Source\Meta\meta-functions.ps1
}

Describe 'Get-WrapperFunctionName ' {
    it 'Should return the correct function name' {

        $testCases=@(
            @{ wrappedFunction='Get-NthWeekdayOfMonth'; Nth='1st'; Day='Saturday'; Expected='Get-1stSaturdayOfMonth' }
            @{ wrappedFunction='Get-NthWeekdayOfMonth'; Nth='2nd'; Day='Friday'; Expected='Get-2ndFridayOfMonth' }
            @{ wrappedFunction='Get-NthLastWeekdayOfMonth'; Nth='3rd'; Day='Monday'; Expected='Get-3rdLastMondayOfMonth' }
            @{ wrappedFunction='Get-NthLastWeekdayOfMonth'; Nth='1st'; Day='Thursday'; Expected='Get-LastThursdayOfMonth' }

           )

        foreach ($testCase in $testCases) {

            Get-WrapperFunctionName -WrappedFunction $testCase.wrappedFunction -Day $testCase.Day -Nth $testCase.Nth|
                Should -BeExactly $testCase.Expected
        }
    }
}
