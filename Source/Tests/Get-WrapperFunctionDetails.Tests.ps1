BeforeAll {
    $TopLevel = Resolve-Path "$PSScriptRoot../../.."
    . $TopLevel\Source\Meta\meta-functions.ps1
}

Describe 'Get-WrapperFunctionDescription' {

    $testCases=@(
        @{ wrappedFunction='Get-NthDayOfWeekInMonth'; N=1; Day='Saturday'; Expected=@{FunctionName = 'Get-1stSaturdayInMonth';Description='1st Saturday';Alias=''} }
        @{ wrappedFunction='Get-NthDayOfWeekInMonth'; N=2; Day='Friday'; Expected=@{FunctionName = 'Get-2ndFridayInMonth';Description='2nd Friday';Alias=''} }
        @{ wrappedFunction='Get-NthLastDayOfWeekInMonth'; N=3; Day='Monday'; Expected=@{FunctionName = 'Get-3rdLastMondayInMonth';Description='3rd Last Monday';Alias=''} }
        @{ wrappedFunction='Get-NthLastDayOfWeekInMonth'; N=1; Day='Thursday'; Expected=@{FunctionName = 'Get-LastThursdayInMonth';Description='Last Thursday';Alias=''} }
        @{ wrappedFunction='Get-NthDayOfWeekInMonth'; N=2; Day='Tuesday'; Expected=@{FunctionName = 'Get-2ndTuesdayInMonth';Description='2nd Tuesday';Alias='Get-PatchTuesday'} }
        @{ wrappedFunction='Get-NthLastDayOfWeekInMonth'; N=2; Day='Tuesday'; Expected=@{FunctionName = 'Get-2ndLastTuesdayInMonth';Description='2nd LAst Tuesday';Alias=''} }

       )
    Context 'Should work for <wrappedFunction>, N=<N>, Day=<Day>' -ForEach $testCases {

        it 'Should return the correct function name' {

            $result = Get-WrapperFunctionDetails -WrappedFunction $wrappedFunction -Day $Day -N $N
            $result.FunctionName | Should -Be $Expected.FunctionName
        }

        it 'Should return the correct function description' {

            $result = Get-WrapperFunctionDetails -WrappedFunction $wrappedFunction -Day $Day -N $N
            $result.Description | Should -Be $Expected.Description
        }

        # it 'Should return the correct function Alias' {

        #     $result = Get-WrapperFunctionDetails -WrappedFunction $wrappedFunction -Day $Day -N $N
        #     $result.Alias | Should -Be $Expected.Alias
        # }

    }
}
