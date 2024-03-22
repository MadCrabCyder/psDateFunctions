BeforeAll {
    $TopLevel = Resolve-Path "$PSScriptRoot../../.."

    . $TopLevel\Source\Public\Get-1stDayOfMonth.ps1
    . $TopLevel\Source\Public\Get-LastDayOfMonth.ps1
    . $TopLevel\Source\Public\Get-NthWeekdayOfMonth.ps1
    . $TopLevel\Source\Public\Get-NthLastWeekdayOfMonth.ps1
}
Describe 'Test Wrapper Functions' {

    BeforeAll {
        Mock Get-NthWeekdayOfMonth
        Mock Get-NthLastWeekdayOfMonth
    }

    # Define weekdays and week ordinals
    $Days = [System.DayOfWeek].GetEnumNames()

    . .\Source\Meta\meta-functions.ps1

    $testCases = foreach ($N in 1..5) {
        foreach ($Day in $Days) {
            foreach ($wrappedFunction in @('Get-NthWeekdayOfMonth', 'Get-NthLastWeekdayOfMonth')) {

                $functionDetails = Get-WrapperFunctionDetails -WrappedFunction $wrappedFunction -Day $Day -N $N

                @{
                    WrappedFunction = $wrappedFunction
                    Day = $day
                    Nth = $N
                    Function = $functionDetails.FunctionName
                }
            }
        }
    }

    Context 'Test Function <Function>' -ForEach $testCases  {

        BeforeEach {
            # Source the function under test
            . "$($TopLevel)\Source\Generated\$($Function).ps1"
        }

        it 'function should exist'  {

            Get-Command $Function -EA SilentlyContinue | Should -Not -BeNullOrEmpty
        }

        it "should call $($WrappedFunction) with correct parameters" {

            &$Function -Month 6 -Year 2023

            Should -Invoke $WrappedFunction -Exactly -Times 1 -ParameterFilter {
                $Year -eq 2023 -and
                $Month -eq 6 -and
                $Nth -eq $Nth -and
                $WeekDay -eq [System.DayOfWeek]$day
            }
        }
    }
}
