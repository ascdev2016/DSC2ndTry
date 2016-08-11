Configuration Main
{
 
[CmdletBinding()]
 
Param (
    [string] $NodeName,
    [string] $domainName,
    [System.Management.Automation.PSCredential]$domainAdminCredentials
)
 
Import-DscResource -ModuleName PSDesiredStateConfiguration, xActiveDirectory, xDisk
 
Node $AllNodes.Where{$_.Role -eq "DC"}.Nodename
    {
        LocalConfigurationManager
        {
            ConfigurationMode = 'ApplyAndAutoCorrect'
            RebootNodeIfNeeded = $true
            ActionAfterReboot = 'ContinueConfiguration'
            AllowModuleOverwrite = $true
        }
		xWaitforDisk Disk2
		{
		DiskNumber = 2
		RetryIntervalSec = 60
		RetryCount = 60
		}
		xDisk FVolume
		{
		DiskNumber = 2
		DriveLetter = 'F'
		}
        WindowsFeature DNS_RSAT
        { 
            Ensure = "Present"
            Name = "RSAT-DNS-Server"
        }
 
        WindowsFeature ADDS_Install 
        { 
            Ensure = 'Present'
            Name = 'AD-Domain-Services'
        } 
 
        WindowsFeature RSAT_AD_AdminCenter 
        {
            Ensure = 'Present'
            Name   = 'RSAT-AD-AdminCenter'
        }
 
        WindowsFeature RSAT_ADDS 
        {
            Ensure = 'Present'
            Name   = 'RSAT-ADDS'
        }
 
        WindowsFeature RSAT_AD_PowerShell 
        {
            Ensure = 'Present'
            Name   = 'RSAT-AD-PowerShell'
        }
 
        WindowsFeature RSAT_AD_Tools 
        {
            Ensure = 'Present'
            Name   = 'RSAT-AD-Tools'
        }
 
        WindowsFeature RSAT_Role_Tools 
        {
            Ensure = 'Present'
            Name   = 'RSAT-Role-Tools'
        }      
 
        WindowsFeature RSAT_GPMC 
        {
            Ensure = 'Present'
            Name   = 'GPMC'
        } 
        xADDomain CreateForest 
        { 
            DomainName = $domainName           
            DomainAdministratorCredential = $domainAdminCredentials
            SafemodeAdministratorPassword = $domainAdminCredentials
            DatabasePath = "C:\Windows\NTDS"
            LogPath = "C:\Windows\NTDS"
            SysvolPath = "C:\Windows\Sysvol"
            DependsOn = '[WindowsFeature]ADDS_Install'
        }
    }
	Node $AllNodes.Where{$_.Role -eq "SQL"}.Nodename
    {
        LocalConfigurationManager
        {
            ConfigurationMode = 'ApplyAndAutoCorrect'
            RebootNodeIfNeeded = $true
            ActionAfterReboot = 'ContinueConfiguration'
            AllowModuleOverwrite = $true
        }
		xWaitforDisk Disk2
		{
		DiskNumber = 2
		RetryIntervalSec = 60
		RetryCount = 60
		}
		xDisk FVolume
		{
		DiskNumber = 2
		DriveLetter = 'F'
		}
				xWaitforDisk Disk3
		{
		DiskNumber = 3
		RetryIntervalSec = 60
		RetryCount = 60
		}
		xDisk GVolume
		{
		DiskNumber = 3
		DriveLetter = 'G'
		}
    }
		Node $AllNodes.Where{$_.Role -eq "SQL"}.Nodename
    {
        LocalConfigurationManager
        {
            ConfigurationMode = 'ApplyAndAutoCorrect'
            RebootNodeIfNeeded = $true
            ActionAfterReboot = 'ContinueConfiguration'
            AllowModuleOverwrite = $true
        }
		xWaitforDisk Disk2
		{
		DiskNumber = 2
		RetryIntervalSec = 60
		RetryCount = 60
		}
		xDisk FVolume
		{
		DiskNumber = 2
		DriveLetter = 'F'
		}
		xWaitforDisk Disk3
		{
		DiskNumber = 3
		RetryIntervalSec = 60
		RetryCount = 60
		}
		xDisk GVolume
		{
		DiskNumber = 3
		DriveLetter = 'G'
		}
		xWaitforDisk Disk4
		{
		DiskNumber = 4
		RetryIntervalSec = 60
		RetryCount = 60
		}
		xDisk HVolume
		{
		DiskNumber = 3
		DriveLetter = 'H'
		}
    }
}