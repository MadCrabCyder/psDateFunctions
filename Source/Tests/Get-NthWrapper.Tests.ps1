BeforeAll {
    $TopLevel = (Split-Path(Split-Path $PSScriptRoot))

    . $TopLevel\Source\Public\Get-FirstDayOfMonth.ps1
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
    $Weeks = @{ 1 = '1st'; 2 = '2nd'; 3 = '3rd'; 4 = '4th'; 5 = '5th' }

    . .\Source\Meta\meta-functions.ps1

    $testCases = foreach ($week in $Weeks.GetEnumerator()) {
        foreach ($day in $Days) {
            foreach ($function in @('Get-NthWeekdayOfMonth', 'Get-NthLastWeekdayOfMonth')) {

                @{
                    WrappedFunction = $function
                    Day = $day
                    Nth = $week.Key
                    NthOrd = $week.Value
                    Function = Get-WrapperFunctionName -wrappedFunction $function -Nth $week.Value -Day $day
                }
            }
        }
    }


    Context 'Test Function <Function>' -ForEach $testCases  {

        BeforeEach {
            # Source the function under test
            . "$($TopLevel)\Source\Generated\$($Function).ps1"
        }

        it 'should exist'  {

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
