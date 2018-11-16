function Import-ActiveDirectory
{
<#
.SYNOPSIS
ADModule Script which could import ActiveDirectory module

.DESCRIPTION
This script will import AD modules without writing files to disk.

.PARAMETER ActiveDirectoryModule
Path to the ActiveDirectoryModule dll.

.EXAMPLE
PS > Import-ActiveDirectory

.EXAMPLE
PS > Import-ActiveDirectory -ActiveDirectoryModule C:\test\Microsoft.ActiveDirectory.Management.dll
#>
    [CmdletBinding()] Param(
        [Parameter(Position = 0, Mandatory = $False)]
        [String]
        $ActiveDirectoryModule
    )

    $retVal = Get-Module -ListAvailable | where { $_.Name -eq "ActiveDirectory" }
    if ($retVal) {
        Import-Module ActiveDirectory
    } else {
        if($ActiveDirectoryModule) {
            $path = Resolve-Path $ActiveDirectoryModule
            $DllBytes = [IO.File]::ReadAllBytes($path)
        } else {
            [Byte[]] $DllBytes = $Data -split ' '
        }
        
        $Assembly = [System.Reflection.Assembly]::Load($DllBytes)
        Import-Module -Assembly $Assembly
    }
}