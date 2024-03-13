# Preferences for ModuleBuilder
# https://github.com/PoshCode/ModuleBuilder
#

@{
    Path = "./Source/psDateFunctions.psd1"

    UnversionedOutputDirectory = $true

    SourceDirectories = @(
        "[Ee]num", "[Cc]lasses", "[Pp]rivate", "[Pp]ublic","[Gg]enerated"
    )

    PublicFilter = @("[Pp]ublic/*.ps1","[Gg]enerated/*.ps1")

}
