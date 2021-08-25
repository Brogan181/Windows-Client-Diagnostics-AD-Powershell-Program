function backupScheduleEnable {

<#
James Brogan

24/08/2021

This module creates a backup schedule for two specified directories
and stores the backups in a specified location.    

To use this module it first must be initiated by the mainProgram.
This can be done by selecting "4" at the main program menu.
The module will prompt the user to determine whether they wish
to create enable a backup schedule for the pre specified directories.
If "yes" or "y" is detected the module will activate the schedule
to backup the directories at 5PM.  The backup will also be run to
ensure that it will work at the schedule time.
#>

  function bakMsg {
"
 =========================================
| Server Backup Schedule Module (5 PM)    |
 =========================================
| by James Brogan   | Created: 5/08/2021  |
 =========================================
"
  }
  
  function bakMsg1 {
"
The backup was successful.  Backup schedule created.

Check task manager for more info.
"
  }

  function bakScheduleEndMsg {
"
Backup schedule session terminated.
"
  }
  
  function bakErrorDisplay0 {
"    

An error has occured.
      
View the log error file for more information.

File path: D:\4CNS\Assignment2\Final Script\Script-Logs\errorlog.txt 
"
  }

  $taskName = "StaffManagerBak"
  
  $bakScriptLocation = "D:\4CNS\Assignment2\Final Script\Modules\4-CreateBackupSchedules"

  $source = "C:\to_backup\All_Staff"

  $source1 = "C:\to_backup\Managers"

  $destination = "C:\bak_store"

  $bakTime = "5pm"

# https://devblogs.microsoft.com/scripting/hey-scripting-guy-how-can-i-back-up-specific-folders-on-my-windows-computer/

# https://www.youtube.com/watch?v=izlIJTmUW0o

  Switch ($backupSchedule = Read-Host -Prompt "`nEnable a 5pm Backup Schedule on a Windows Server for the Directories:`n`n`"C:\to_backup\All_Staff`" and `"C:\to_backup\Managers`"? Y/N")
  {
    "y" {
           Copy-Item -Path "$source", "$source1" -destination "$destination" –recurse
             $action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument "$bakScriptLocation" 
             $bakSchedule = New-ScheduledTaskTrigger -Daily -At "$bakTime" 
             Register-ScheduledTask `
             -TaskName $taskName `
             -Action $action `
             -Trigger $bakSchedule 
             bakMsg1
        }

    "yes" {
             Copy-Item -Path "$source", "$source1" -destination "$destination" –recurse
             $action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument "$bakScriptLocation" 
             $bakSchedule = New-ScheduledTaskTrigger -Daily -At "$bakTime" 
             Register-ScheduledTask `
             -TaskName $taskName `
             -Action $action `
             -Trigger $bakSchedule 
             bakMsg1
           }

    "n" {
           bakScheduleEndMsg
           return
        }

    "no" {
            bakScheduleEndMsg
            return
         }

    default {
               bakErrorDisplay0
               "Incorect character typed within the backup schedule module." | out-file -FilePath "D:\4CNS\Assignment2\Final Script\Script-Logs\errorlog.txt" -Append
               Write-Host "Please enter a valid character."
            }
  }
}
