# Generate a series of wrapper functions for Get-NthWeekdayOfMonth and
# Get-NthLastWeekdayOfMonth based on combinations of weeks (1st, 2nd, 3rd, etc.)
# and days of the week. The script also includes a special case for creating an
# alias for "Patch Tuesday".

. .\Source\Meta\meta-functions.ps1

# Define weekdays and week ordinals
$Days = [System.DayOfWeek].GetEnumNames()
$Weeks = @{
    1 = '1st'
    2 = '2nd'
    3 = '3rd'
    4 = '4th'
    5 = '5th'
}

# Define the target directory and remove any previously generated scripts
$targetDirectory = ".\Source\Generated\"
if (-not (Test-Path -Path $targetDirectory)) {
    New-Item -ItemType Directory -Force -Path $targetDirectory
}
Get-ChildItem -Path $targetDirectory -Filter "*.ps1" | Remove-Item


# Main loop to generate functions
foreach ($week in $Weeks.GetEnumerator()) {
    foreach ($day in $Days) {
        foreach ($function in @('Get-NthWeekdayOfMonth', 'Get-NthLastWeekdayOfMonth')) {


            $functionName = Get-WrapperFunctionName -wrappedFunction $function -Nth $week.Value -Day $day
            $functionContent = Get-WrapperFunctionContent -functionName $functionName -wrappedFunction $function -day $day -week $week.Key
            $functionPath = Join-Path -Path $targetDirectory -ChildPath "$functionName.ps1"
            $functionContent | Out-File -FilePath $functionPath

        }
    }
}

