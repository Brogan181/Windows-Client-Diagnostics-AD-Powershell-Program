mainProgram

function mainProgram {

Import-Module -Name 'D:\4CNS\Assignment2\Final Script\Modules\1-CheckClientandServerConectivity.psm1' -Verbose 
Import-Module -Name 'D:\4CNS\Assignment2\Final Script\Modules\2-CreateNewUsers.psm1' -Verbose 
Import-Module -Name 'D:\4CNS\Assignment2\Final Script\Modules\3-CreateNewOrganizationalUnit.psm1' -Verbose 
Import-Module -Name 'D:\4CNS\Assignment2\Final Script\Modules\4-CreateBackupSchedules.psm1' -Verbose 
Import-Module -Name 'D:\4CNS\Assignment2\Final Script\Modules\5-CheckServerHDDspace.psm1' -Verbose 
Import-Module -Name 'D:\4CNS\Assignment2\Final Script\Modules\6-Get-Client-OSInfo.psm1' -Verbose 
Import-Module -Name 'D:\4CNS\Assignment2\Final Script\Modules\7-CheckSecurityLogs.psm1' -Verbose 

  function mainSelectMenu {
"    
===============( Fox-it Car Parts Program )================= 
|                                                          |
|                                                          |
|   Please type a character to select from the following:  |
|                                                          |
|                                                          |
|   Type 1  for:  Server-Client Conectivity Check          |
|                                                          |
|   Type 2  for:  Create New Users in Active Directory     |
|                                                          |
|   Type 3  for:  Create A New Orginisational Unit         |
|                                                          |
|   Type 4  for:  Enable Backup Schedule                   |
|                                                          |
|   Type 5  for:  Check Server HHD Space                   |
|                                                          |
|   Type 6  for:  Get Client Computer Info                 |
|                                                          |
|   Type 7  for:  View Server Security Logs                |
|                                                          |
|==========================================================|  
|                                                          |
|               Type 'q' to:  Quit Program                 |
|                                                          |
------------------------------------------------------------
"
  }

  function errorDisplay0 {
"    
Please enter a valid character.

An error has occured.
      
View the log error file for more information.

File path: D:\4CNS\Assignment2\Final Script\Script-Logs\errorlog.txt  
"
  }

  While ($selection -ne "q") {
    
    Start-Sleep -Seconds 1
    
    $errorCount = 0

    $endLog = "`nProgram Stopped.`n`n$errorCount error(s) occured during this session.`n`nView the log error file for more information.`n`nFile path: D:\4CNS\Assignment2\Final Script\Script-Logs\errorlog.txt `n"
    
    mainSelectMenu
             
    Switch ($selection = Read-Host "Selection") {
      "1" {svrCliConnect}
      "2" {newADUsers}
      "3" {newOrganisationalUnit}
      "4" {backupScheduleEnable}
      "5" {svrHardDiskSpace}
      "6" {remoteClientInfo}
      "7" {viewSecurityLog}
      "q"{Write-Host $endLog}
      default {
                 errorDisplay0
                 "Incorect character typed on the main menu" | out-file -FilePath "D:\4CNS\Assignment2\Final Script\Script-Logs\errorlog.txt" -Append
                 $errorCount++ 
      }
    }            
  }
}