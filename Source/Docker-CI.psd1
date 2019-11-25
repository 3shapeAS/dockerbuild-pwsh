#
# Module manifest for module 'Docker.Build'
#
# Generated by: 3Shape A/S
#
# Generated on: 04/10/2019
#
@{

    # Script module or binary module file associated with this manifest.
    RootModule           = 'Docker-CI.psm1'

    # Version number of this module. Will be updated by CI/CD but included here so it's possible to source the module locally.
    ModuleVersion        = '0.0.1'

    # Supported PSEditions
    CompatiblePSEditions = 'Core'

    # ID used to uniquely identify this module
    GUID                 = '006752EA-7AEB-40BE-9B64-A7396F8EA242'

    # Author of this module
    Author               = '3Shape A/S'

    # Company or vendor of this module
    CompanyName          = '3Shape'

    # Copyright statement for this module
    Copyright            = '(c) 2019 3Shape, licensed under the Apache 2.0 license.'

    # Description of the functionality provided by this module
    Description          = 'PowerShell module to build, test and publish docker images.'

    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion    = '6.0'

    # Name of the Windows PowerShell host required by this module
    # PowerShellHostName = ''

    # Minimum version of the Windows PowerShell host required by this module
    # PowerShellHostVersion = ''

    # Minimum version of Microsoft .NET Framework required by this module
    # DotNetFrameworkVersion = ''

    # Minimum version of the common language runtime (CLR) required by this module
    # CLRVersion = ''

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
    #FormatsToProcess = 'PSStackExchange.Format.ps1xml'

    # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
    # NestedModules = @()

    # Functions to export from this module
    FunctionsToExport    = @("Invoke-DockerBuild, Invoke-DockerTag", "Invoke-DockerLint")

    # Cmdlets to export from this module
    CmdletsToExport      = '*'

    # Variables to export from this module
    VariablesToExport    = '*'

    # Aliases to export from this module
    AliasesToExport      = '*'

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData          = @{

        PSData = @{

            # Tags applied to this module. These help with module discovery in online galleries.
            Tags       = @('powershell', 'core', 'docker', 'build', 'test', 'lint', 'pipeline', 'structure', 'container', 'Windows', 'Linux')

            # A URL to the license for this module.
            LicenseUri = 'https://www.apache.org/licenses/LICENSE-2.0.txt'

            # A URL to the main website for this project.
            ProjectUri = 'https://github.com/3shape/docker-ci'

            # A URL to an icon representing this module.
            # IconUri = ''

            # ReleaseNotes of this module
            # ReleaseNotes = ''

        } # End of PSData hashtable

    } # End of PrivateData hashtable

    # HelpInfo URI of this module
    # HelpInfoURI = ''

    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    # DefaultCommandPrefix = ''

}
