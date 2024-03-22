BeforeAll {
    $TopLevel = Resolve-Path "$PSScriptRoot../../.."
    . $TopLevel\Source\Meta\meta-functions.ps1
}

Describe 'Get-OrdinalNumber' {

    $testCases = @(
        @{N = 1; Expected = '1st'}
        @{N = 2; Expected = '2nd'}
        @{N = 3; Expected = '3rd'}
        @{N = 4; Expected = '4th'}
        @{N = 5; Expected = '5th'}
    )

    it 'Should return <Expected> for <N>' -ForEach $testCases {

        Get-OrdinalNumber $N | Should -BeExactly $Expected
    }
}
