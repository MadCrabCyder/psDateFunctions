# Generate a series of wrapper functions for Get-NthDayOfWeekInMonth and
# Get-NthLastDayOfWeekInMonth based on combinations of weeks (1st, 2nd, 3rd, etc.)
# and days of the week. The script also includes a special case for creating an
# alias for "Patch Tuesday".

. .\Source\Meta\meta-functions.ps1

# Define the target directory and remove any previously generated scripts
$targetDirectory = ".\Source\Generated\"

Get-ChildItem -Path $targetDirectory -Filter "*.ps1" | Remove-Item


# Main loop to generate functions
foreach ($N in $script:SupportedOrdinals) {
    foreach ($Day in $script:Days) {
        foreach ($wrappedFunction in $script:WrapperTargets) {

            $functionDetails = Get-WrapperFunctionDetails -WrappedFunction $wrappedFunction -Day $Day -N $N

            $functionContent = Get-WrapperFunctionContent -FunctionDetails $functionDetails -wrappedFunction $wrappedFunction -Day $Day -N $N

            $functionPath = Join-Path -Path $targetDirectory -ChildPath "$($functionDetails.FunctionName).ps1"

            $existingContent = if (Test-Path -Path $functionPath -PathType Leaf) {
                Get-Content -Path $functionPath -Raw
            }
            else {
                $null
            }

            if ($existingContent -ne $functionContent) {
                $functionContent | Out-File -FilePath $functionPath
            }
        }
    }
}

