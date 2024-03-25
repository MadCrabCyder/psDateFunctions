#
# Module manifest for module 'psDateFunctions'
#

@{

# Script module or binary module file associated with this manifest.
RootModule = '.\psDateFunctions.psm1'

# Version number of this module.
ModuleVersion = '1.0.0'

# Supported PSEditions
# CompatiblePSEditions = @('Desktop', 'Core')

# ID used to uniquely identify this module
GUID = '92bd8191-fb2a-49e8-8474-a0d6fffed2e6'

# Author of this module
Author = 'Mad Crab Cyder'

# Company or vendor of this module
CompanyName = 'Mad Crab Cyder Productions'

# Copyright statement for this module
Copyright = '(c) Mad Crab Cyder. All rights reserved.'

# Description of the functionality provided by this module
Description = 'This PowerShell module is ideal for planning, scheduling, and IT operations, enabling users to find the first and last days of a month, any variation of the nth instance, or nth last instance of a particular weekday in a month, including Patch Tuesday.'

# Minimum version of the PowerShell engine required by this module
# PowerShellVersion = ''

# Name of the PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# ClrVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @()

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @('Date','Dates','Scheduling','Patch','PatchTuesday','WindowsUpdate')

        # A URL to the license for this module.
        LicenseUri = 'https://raw.githubusercontent.com/MadCrabCyder/psDateFunctions/master/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/MadCrabCyder/psDateFunctions'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        ReleaseNotes = 'Release version 1, now available'

        # Prerelease string of this module
        Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

