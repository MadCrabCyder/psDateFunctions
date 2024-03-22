BeforeAll {
    $TopLevel = Resolve-Path "$PSScriptRoot../../.."
    . $TopLevel\Source\Meta\meta-functions.ps1
}

Describe 'Get-WrapperFunctionDescription' {

    $testCases=@(
        @{ wrappedFunction='Get-NthWeekdayOfMonth'; N=1; Day='Saturday'; Expected=@{FunctionName = 'Get-1stSaturdayOfMonth';Description='1st Saturday';Alias=''} }
        @{ wrappedFunction='Get-NthWeekdayOfMonth'; N=2; Day='Friday'; Expected=@{FunctionName = 'Get-2ndFridayOfMonth';Description='2nd Friday';Alias=''} }
        @{ wrappedFunction='Get-NthLastWeekdayOfMonth'; N=3; Day='Monday'; Expected=@{FunctionName = 'Get-3rdLastMondayOfMonth';Description='3rd Last Monday';Alias=''} }
        @{ wrappedFunction='Get-NthLastWeekdayOfMonth'; N=1; Day='Thursday'; Expected=@{FunctionName = 'Get-LastThursdayOfMonth';Description='Last Thursday';Alias=''} }
        @{ wrappedFunction='Get-NthWeekdayOfMonth'; N=2; Day='Tuesday'; Expected=@{FunctionName = 'Get-2ndTuesdayOfMonth';Description='2nd Tuesday';Alias='Get-PatchTuesday'} }
        @{ wrappedFunction='Get-NthLastWeekdayOfMonth'; N=2; Day='Tuesday'; Expected=@{FunctionName = 'Get-2ndLastTuesdayOfMonth';Description='2nd LAst Tuesday';Alias=''} }

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

        it 'Should return the correct function Alias' {

            $result = Get-WrapperFunctionDetails -WrappedFunction $wrappedFunction -Day $Day -N $N
            $result.Alias | Should -Be $Expected.Alias
        }

    }
}
