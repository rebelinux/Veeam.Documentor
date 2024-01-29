<p align="center">
    <a href="https://github.com/rebelinux/Veeam.Documentor" alt="Veeam.Documentor"></a>
            <img src='https://raw.githubusercontent.com/rebelinux/Veeam.Documentor/dev/icons/DMAD_Logo.png' width="8%" height="8%" /></a>
</p>
<p align="center">
    <a href="https://www.powershellgallery.com/packages/Veeam.Documentor/" alt="PowerShell Gallery Version">
        <img src="https://img.shields.io/powershellgallery/v/Veeam.Documentor.svg" /></a>
    <a href="https://www.powershellgallery.com/packages/Veeam.Documentor/" alt="PS Gallery Downloads">
        <img src="https://img.shields.io/powershellgallery/dt/Veeam.Documentor.svg" /></a>
    <a href="https://www.powershellgallery.com/packages/Veeam.Documentor/" alt="PS Platform">
        <img src="https://img.shields.io/powershellgallery/p/Veeam.Documentor.svg" /></a>
</p>
<p align="center">
    <a href="https://github.com/rebelinux/Veeam.Documentor/graphs/commit-activity" alt="GitHub Last Commit">
        <img src="https://img.shields.io/github/last-commit/rebelinux/Veeam.Documentor.svg" /></a>
    <a href="https://raw.githubusercontent.com/rebelinux/Veeam.Documentor/master/LICENSE" alt="GitHub License">
        <img src="https://img.shields.io/github/license/rebelinux/Veeam.Documentor.svg" /></a>
    <a href="https://github.com/rebelinux/Veeam.Documentor/graphs/contributors" alt="GitHub Contributors">
        <img src="https://img.shields.io/github/contributors/rebelinux/Veeam.Documentor.svg"/></a>
</p>
<p align="center">
    <a href="https://twitter.com/jcolonfzenpr" alt="Twitter">
            <img src="https://img.shields.io/twitter/follow/jcolonfzenpr.svg?style=social"/></a>
</p>
<p align="center">
    <a href='https://ko-fi.com/F1F8DEV80' target='_blank'><img height='36' style='border:0px;height:36px;' src='https://cdn.ko-fi.com/cdn/kofi1.png?v=3'            border='0' alt='Buy Me a Coffee at ko-fi.com' /></a>
</p>

# Veeam Documentor

<!-- ********** REMOVE THIS MESSAGE WHEN THE MODULE IS FUNCTIONAL ********** -->
## :exclamation: THIS POWERSHELL MODULE IS CURRENTLY IN DEVELOPMENT AND MIGHT NOT YET BE FUNCTIONAL ❗

Veeam.Documentor is a PowerShell module to automatically export the configuration of Veeam Backup & Replication to an Excel wordbook.

> Special thanks & shoutout to [`Doug Finke`](https://twitter.com/dfinke) and his [`ImportExcel`](https://github.com/dfinke/ImportExcel) module.

## :books: Sample Diagram

### Veeam Wordbook

![!\[Wordbook\](Forest_Diagram.webp)](Samples/Forest_Diagram.webp)

# :beginner: Getting Started

Below are the instructions on how to install, configure and generate a Veeam.Diagrammer diagram.

## :floppy_disk: Supported Versions
<!-- ********** Update supported Veeam versions ********** -->
The Veeam.Diagrammer supports the following Veeam Backup & Replication version;

- Veeam Backup & Replication V11 (Standard, Enterprise & Enterprise Plus Edition)
- Veeam Backup & Replication v12+ (Standard, Enterprise & Enterprise Plus Edition)

### :closed_lock_with_key: Required Privileges

Only users with Veeam Backup Administrator role assigned can generate a Diagram

### PowerShell

This project is compatible with the following PowerShell versions;

<!-- ********** Update supported PowerShell versions ********** -->
| Windows PowerShell 5.1 |     PowerShell 7    |
|:----------------------:|:--------------------:|
|   :white_check_mark:   | :x: |

## :wrench: System Requirements

PowerShell 5.1, and the following PowerShell modules are required for generating a Veeam.Diagrammer diagram.

- [Veeam.Backup.PowerShell Module](https://helpcenter.veeam.com/docs/backup/powershell/getting_started.html?ver=110)
- [ImportExcel Module](https://github.com/dfinke/ImportExcel)

## :package: Module Installation

### PowerShell v5.x running on Windows 10 client computer
<!-- ********** Add installation for any additional PowerShell module(s) ********** -->
```powershell

install-module -Name Veeam.Documentor

```

### GitHub

If you are unable to use the PowerShell Gallery, you can still install the module manually. Ensure you repeat the following steps for the [system requirements](https://github.com/rebelinux/Veeam.Documentor#wrench-system-requirements) also.

1. Download the code package / [latest release](https://github.com/rebelinux/Veeam.Documentor/releases/latest) zip from GitHub
2. Extract the zip file
3. Copy the folder `Veeam.Documentor` to a path that is set in `$env:PSModulePath`.
4. Open a PowerShell terminal window and unblock the downloaded files with

    ```powershell
    $path = (Get-Module -Name Veeam.Documentor -ListAvailable).ModuleBase; Unblock-File -Path $path\*.psd1; Unblock-File -Path $path\Src\Public\*.ps1; Unblock-File -Path $path\Src\Private\*.ps1
    ```

5. Close and reopen the PowerShell terminal window.

_Note: You are not limited to installing the module to those example paths, you can add a new entry to the environment variable PSModulePath if you want to use another path._


## :pencil2: Commands

### **New-VeeamDocExport**

The `New-VeeamDocExport` cmdlet is used to generate a Active Directory diagram. The type of diagram to generate is specified by using the `DiagramType` parameter. The DiagramType parameter relies on additional diagram modules being created alongside the defaults module. The `Target` parameter specifies one or more Forest/Domain servers on which to connect and run the diagram. User credentials to the system are specifed using the `Credential`, or the `Username` and `Password` parameters. One or more document formats, such as `PNG`, `PDF`, `SVG`, `BASE64` or `DOT` can be specified using the `Format` parameter. Additional parameters are outlined below.

```powershell
.PARAMETER Target
  Specifies the IP/FQDN of the system to connect.
  Multiple targets may be specified, separated by a comma.
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
.PARAMETER EnableErrorDebug
  Control to enable error debugging.
.PARAMETER Logo
  Allow to change the Microsoft logo to a custom one.
  Image should be 400px x 100px or less in size.
```

For a full list of common parameters and examples you can view the `New-VeeamDocExport` cmdlet help with the following command;

```powershell
Get-Help New-VeeamDocExport -Full
```

## :computer: Examples

There are a few examples listed below on running the Veeam.Documentor script against a Domain Controller Server. Refer to the `README.md` file in the main Veeam.Documentor project repository for more examples.

```powershell
# Generate a Veeam.Documentor diagram for Backup Server 'backupserver-01.pharmax.local' using specified credentials. Use default report style. Save reports to 'C:\Users\Jon\Documents'
PS C:\> New-VeeamDocExport -Target backupserver-01.pharmax.local -Username 'Domain\ad_admin' -Password 'P@ssw0rd' -OutputFolderPath 'C:\Users\Jon\Documents'

# Generate a Veeam.Documentor diagram for Backup Server backupserver-01.pharmax.local using stored credentials. Save reports to 'C:\Users\Jon\Documents'.
PS C:\> $Creds = Get-Credential
PS C:\> New-VeeamDocExport -Target dc-01.pharmax.local -Credential $Creds -OutputFolderPath 'C:\Users\Jon\Documents'

```

## :x: Known Issues

- Since many of Veeam's features depend on the Standard+ license, the Community edition is not supported.
