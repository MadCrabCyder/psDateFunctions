# These functions are used to generate the wrapper functions
# but are not included in the actual module

$script:WrapperFunctionTemplatePath = Join-Path $PSScriptRoot 'Templates\WrapperFunction.ps1.tpl'
$script:WrapperFunctionTemplate = $null
$script:WrapperTargets = @('Get-NthDayOfWeekInMonth', 'Get-NthLastDayOfWeekInMonth')
$script:Days = [System.DayOfWeek].GetEnumNames()
$script:SupportedOrdinals = 1..5

function Get-WrapperFunctionTemplate {
    if (-not $script:WrapperFunctionTemplate) {
        if (-not (Test-Path -Path $script:WrapperFunctionTemplatePath -PathType Leaf)) {
            throw "Wrapper function template not found: $script:WrapperFunctionTemplatePath"
        }

        $script:WrapperFunctionTemplate = Get-Content -Path $script:WrapperFunctionTemplatePath -Raw
    }

    return $script:WrapperFunctionTemplate
}

function Expand-Template {
    param (
        [string]$Template,
        [hashtable]$Values
    )

    $content = $Template
    foreach ($key in $Values.Keys) {
        $content = $content.Replace("{{${key}}}", [string]$Values[$key])
    }

    return $content.TrimEnd([char[]]"`r`n")
}

function Get-OrdinalNumber {
    param (
        [int]$Num
    )
    $Suffix = switch -regex ($Num) {
        '1(1|2|3)$' { 'th'; break }
        '.?1$'      { 'st'; break }
        '.?2$'      { 'nd'; break }
        '.?3$'      { 'rd'; break }
        default     { 'th'; break }
    }
    return "$Num$Suffix"
}

# function Get-WrapperFunctionName {
#     param (
#         [string]$WrappedFunction,
#         [string]$Day,
#         [string]$Nth
#     )

#     $last = ($WrappedFunction -match 'Last') ? "Last" : ""
#     $Nth = ($last -and $Nth -eq '1st') ? "" : $Nth

#     return "Get-$($Nth)$($last)$($Day)InMonth"
# }

# function Get-WrapperFunctionDescription {
#     param (
#         [string]$WrappedFunction,
#         [string]$Day,
#         [string]$NthOrd
#     )
#     $last = ($WrappedFunction -match 'Last') ? "Last" : ""
#     $NthOrd = ($last -and $NthOrd -eq '1st') ? "" : $NthOrd

#     return "$($NthOrd) $($last) $($Day)" -replace '\s\s+',' ' -replace '^\s+',''

# }

function Get-WrapperFunctionDetails {
    param (
        [string]$WrappedFunction,
        [string]$Day,
        [int]$N
    )
    $last = if ($WrappedFunction -match 'Last') { 'Last' } else { '' }

    $NthOrd = if ($last -and $N -eq 1) { "" } else { Get-OrdinalNumber -Num $N }

    $description = "$($NthOrd) $($last) $($Day)" -replace '\s\s+', ' ' -replace '^\s+', ''

    $functionName = "Get-$($description -replace '\s','' )InMonth"

    return @{ FunctionName = $functionName; Description = $description }
}

function Get-WrapperFunctionContent {
    param (
        [Hashtable]$FunctionDetails,
        [string]$wrappedFunction,
        [string]$Day,
        [int]$N

    )
    $template = Get-WrapperFunctionTemplate

    return Expand-Template -Template $template -Values @{
        Description = $FunctionDetails.Description
        FunctionName = $FunctionDetails.FunctionName
        WrappedFunction = $wrappedFunction
        Day = $Day
        Nth = $N
    }
}

# function Get-WrapperFunctionTestContent {
# param (
#     [string]$functionName,
#     [string]$wrappedFunction,
#     [string]$day,
#     [int]$week
# )
#     return @"

#     It "$functionName calls $wrappedFunction with correct parameters" {

#         # Mock $wrappedFunction { return `$null }
#         . `$TopLevel\Source\Generated\$functionName.ps1
#         $functionName -Month 1 -Year 2023
#         Should -Invoke $wrappedFunction -Exactly -Times 1 -ParameterFilter {
#             `$Month -eq 1 -and `$Year -eq 2023 -and `$WeekDay -eq [System.DayOfWeek]::$day -and `$Nth -eq $week
#         }
#     }
# "@
# }
