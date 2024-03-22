# Generate a series of wrapper functions for Get-NthWeekdayOfMonth and
# Get-NthLastWeekdayOfMonth based on combinations of weeks (1st, 2nd, 3rd, etc.)
# and days of the week. The script also includes a special case for creating an
# alias for "Patch Tuesday".

. .\Source\Meta\meta-functions.ps1

# Define weekdays
$Days = [System.DayOfWeek].GetEnumNames()

# Define the target directory and remove any previously generated scripts
$targetDirectory = ".\Source\Generated\"

Get-ChildItem -Path $targetDirectory -Filter "*.ps1" | Remove-Item


# Main loop to generate functions
foreach ($N in 1..5) {
    foreach ($Day in $Days) {
        foreach ($wrappedFunction in @('Get-NthWeekdayOfMonth', 'Get-NthLastWeekdayOfMonth')) {

            $functionDetails = Get-WrapperFunctionDetails -WrappedFunction $wrappedFunction -Day $Day -N $N

            $functionContent = Get-WrapperFunctionContent -FunctionDetails $functionDetails -wrappedFunction $wrappedFunction -Day $Day -N $N

            $functionPath = Join-Path -Path $targetDirectory -ChildPath "$($functionDetails.FunctionName).ps1"
            $functionContent | Out-File -FilePath $functionPath
        }
    }
}

