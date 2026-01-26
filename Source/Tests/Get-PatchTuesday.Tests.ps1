BeforeAll {
    $TopLevel = Resolve-Path "$PSScriptRoot../../.."

    . $TopLevel\Source\Generated\Get-2ndTuesdayInMonth.ps1
    . $TopLevel\Source\Public\Get-PatchTuesday.ps1
}

Describe 'Get-PatchTuesday' {

    BeforeEach {
        Mock -CommandName Get-2ndTuesdayInMonth {
            return [datetime]'2026-01-01'
        }
    }

    $testCases = @(
        @{ Month = 1; Year = 2026 },
        @{ Month = 3; Year = 2025 },
        @{ Month = 12; Year = 2024 }
    )

    it 'Given Year=<Year>, Month=<Month> should call Get-2ndTuesdayInMonth with correct params' -ForEach $testCases {

        # Act
        Get-PatchTuesday -Month $Month -Year $Year

        $expectedMonth = $Month
        $expectedYear = $Year

        # Assert
        Assert-MockCalled -CommandName Get-2ndTuesdayInMonth -Exactly 1  -Scope It -ParameterFilter {
             $Month -eq $expectedMonth -and
             $Year -eq $expectedYear
        }
    }
}
