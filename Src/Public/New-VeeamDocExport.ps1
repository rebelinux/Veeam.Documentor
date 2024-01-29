function New-VeeamDocExport {
    <#
    .SYNOPSIS
        Diagram the configuration of Veeam Backup & Replication infrastructure in PDF/SVG/DOT/PNG formats using PSGraph and Graphviz.
    .DESCRIPTION
        Diagram the configuration of Veeam Backup & Replication infrastructure in PDF/SVG/DOT/PNG formats using PSGraph and Graphviz.
    .PARAMETER Target
        Specifies the IP/FQDN of the system to connect.
        Multiple targets may be specified, separated by a comma.
    .PARAMETER Port
        Specifies a optional port to connect to Veeam VBR Service.
        By default, port will be set to 9392
    .PARAMETER Credential
        Specifies the stored credential of the target system.
    .PARAMETER Username
        Specifies the username for the target system.
    .PARAMETER Password
        Specifies the password for the target system.
    .PARAMETER OutputFolderPath
        Specifies the folder path to save the diagram.
    .PARAMETER Filename
        Specifies a filename for the diagram.
    .PARAMETER EnableEdgeDebug
        Control to enable edge debugging ( Dummy Edge and Node lines ).
    .NOTES
        Version:        0.1.1
        Author(s):      Jonathan Colon
        Twitter:        @jcolonfzenpr
        Github:         rebelinux
        Credits:        Doug Finke (@dfinke) -  ImportExcel module
    .LINK
        https://github.com/rebelinux/Veeam.Documentor
    #>

    [Diagnostics.CodeAnalysis.SuppressMessage(
        'PSUseShouldProcessForStateChangingFunctions',
        ''
    )]

    [CmdletBinding(
        PositionalBinding = $false,
        DefaultParameterSetName = 'Credential'
    )]
    param (

        [Parameter(
            Position = 0,
            Mandatory = $true,
            HelpMessage = 'Please provide the IP/FQDN of the system'
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('Server', 'IP')]
        [String[]] $Target,

        [Parameter(
            Position = 1,
            Mandatory = $true,
            HelpMessage = 'Please provide credentials to connect to the system',
            ParameterSetName = 'Credential'
        )]
        [ValidateNotNullOrEmpty()]
        [PSCredential] $Credential,

        [Parameter(
            Position = 2,
            Mandatory = $true,
            HelpMessage = 'Please provide the username to connect to the target system',
            ParameterSetName = 'UsernameAndPassword'
        )]
        [ValidateNotNullOrEmpty()]
        [String] $Username,

        [Parameter(
            Position = 3,
            Mandatory = $true,
            HelpMessage = 'Please provide the password to connect to the target system',
            ParameterSetName = 'UsernameAndPassword'
        )]
        [ValidateNotNullOrEmpty()]
        [String] $Password,

        [Parameter(
            Position = 5,
            Mandatory = $false,
            HelpMessage = 'TCP Port of target Veeam Backup Server'
        )]
        [string] $Port = '9392',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide the path to the wordbook output file'
        )]
        [ValidateScript( {
            if (Test-Path -Path $_) {
                $true
            } else {
                throw "Path $_ not found!"
            }
        })]
        [string] $OutputFolderPath = [System.IO.Path]::GetTempPath(),

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide the path to the custom logo'
        )]
        [ValidateScript( {
            if (Test-Path -Path $_) {
                $true
            } else {
                throw "File $_ not found!"
            }
        })]
        [string] $Logo,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Specify the wordbook filename'
        )]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
            if ($Format.count -lt 2) {
                $true
            } else {
                throw "Format value must be unique if Filename is especified."
            }
        })]
        [String] $Filename,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to enable error debugging'
        )]
        [Switch] $EnableErrorDebug = $false
        )


    begin {

        # If Username and Password parameters used, convert specified Password to secure string and store in $Credential
        #@tpcarman
        if (($Username -and $Password)) {
            $SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force
            $Credential = New-Object System.Management.Automation.PSCredential ($Username, $SecurePassword)
        }

        $RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
        $IconPath = Join-Path $RootPath 'icons'

        # Validate Custom logo
        $CustomLogo = Test-Logo -LogoPath $Logo

        # Validate Veeam Powershell Module
        Get-VbrRequiredModule -Name 'ImportExel' -Version '7.8.6'

    }

    process {

        foreach ($System in $Target) {

            Get-VbrServerConnection -Port $Port

            try {

                $script:VBRServer = Get-VBRServer -Type Local

            } Catch {throw "Unable to connect to Veeam B&R Server: $System"}

        }
    }
    end {
        #Export wordbook
        Export-Excel
    }
}