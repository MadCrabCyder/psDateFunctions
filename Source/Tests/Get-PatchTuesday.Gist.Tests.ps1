BeforeAll {
    $TopLevel = Resolve-Path "$PSScriptRoot../../.."

    . $TopLevel\Source\Gist\Get-PatchTuesday.ps1
}

Describe 'Get-PatchTuesday Gist - Happy Path' {
    $testCases = @(
        @{ Month = 1; Year = 2026; ExpectedDay = 13 }
        @{ Month = 3; Year = 2025; ExpectedDay = 11 }
        @{ Month = 12; Year = 2024; ExpectedDay = 10 }
        @{ Month = 9; Year = 2024; ExpectedDay = 10 }
        @{ Month = 2; Year = 2024; ExpectedDay = 13 }
    )

    it 'Given Year=<Year>, Month=<Month>, should return the Patch Tuesday date' -ForEach $testCases {
        Get-PatchTuesday -Month $Month -Year $Year |
            Should -BeExactly ([datetime]::new($Year, $Month, $ExpectedDay))
    }
}

Describe 'Get-PatchTuesday Gist - Exceptions' {
    $invalidMonthCases = @(
        @{ Year = 2026; Month = 0 }
        @{ Year = 2026; Month = -1 }
        @{ Year = 2026; Month = 13 }
        @{ Year = 2026; Month = 99 }
    )

    it 'Given invalid Month=<Month>, should throw an exception' -ForEach $invalidMonthCases {
        { Get-PatchTuesday -Month $Month -Year $Year } |
            Should -Throw 'Invalid Month'
    }

    $invalidYearCases = @(
        @{ Year = 0; Month = 1 }
        @{ Year = -1; Month = 1 }
        @{ Year = 10000; Month = 1 }
    )

    it 'Given invalid Year=<Year>, should throw an exception' -ForEach $invalidYearCases {
        { Get-PatchTuesday -Month $Month -Year $Year } |
            Should -Throw 'Invalid Year'
    }
}
