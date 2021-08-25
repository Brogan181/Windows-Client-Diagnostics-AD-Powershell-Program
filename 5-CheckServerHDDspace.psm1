function svrHardDiskSpace {

<#
James Brogan

24/08/2021

This module checks a specified hard drives free space and issues
a warning to the user if it is low or below a certain threshold.    

To use this module it first must be initiated by the mainProgram.
This can be done by selecting "5" at the main program menu.
The module will prompt the user to determine whether they wish
to to check the computer's hard drive space.  If "yes" or "y" 
is detected the module will prompt the user for a drive ID.
Once a drive ID has been entered e.g. "D."  The module will 
check the drive and determine its remaining free space. 
Once it's free space has been determined, the module 
will determine whether the number is below or above the
warning threshold.  If it is below a warning will be issued
to the user. 
#>

$diskWarningThresholdForCalc = 20GB

$diskWarningThresholdForDisp = "20GB"

function diskCheckDisplay {
"
 Disk `"$diskID`" is displayed below:
==============================
"
}

  function svrHDDSpaceMsg {
"
 =========================================
| Check Server Remaining HDD Space        |
 =========================================
| by James Brogan   | Created: 3/08/2021  |
 =========================================
"
  }

  function checkingHHDSpace {
"
Checking this devices HDD space...
"
  }

 function enoughHDDSpace {
 "
This disk ($diskID) has sufficient disk space remaining.
 "
 }
  
  
  function lowHDDWarning {
"
============( WARNING )=============
   
Server storage is nearly empty. 

Under $diskWarningThresholdForDisp of free space remains.
"
  }
  
  function diskCheckWarn {
        
    $diskID = Read-Host "`nInput a diskID to view its remaining disk space e.g.`"C`" `nto see the C drive"
  
    checkingHHDSpace
  
    diskCheckDisplay
  
    $disk = Get-PSDrive $diskID | Select-Object Used,Free 
  
    $diskRoundingGb = New-Object PSObject -Property @{
       Used     = [math]::Round($disk.Used / 1073741824, 2)
       Free     = [math]::Round($disk.Free / 1073741824, 2)
     }
    $diskRoundingGb
    
    Start-Sleep -Milliseconds 300

    if ($disk.Free -le $diskWarningThresholdForCalc){
      lowHDDWarning
    } 
  
    Else {
      enoughHDDSpace
    }
    Start-Sleep -Milliseconds 300
  }

  svrHDDSpaceMsg
  
  While ($initiateDiskModule -ne "n","no","q") {

    Switch ($initiateDiskModule = Read-Host -Prompt "Do you want to check the computer's hard drive space? Y/N"){
                
              "y" {
                    diskCheckWarn 
                   
              }
               
              "yes" {
                      diskCheckWarn 
                     
              }
               
              "n"{
                    Write-Host "`nDisk space module terminated."
                    return
              }
    
              "no"{
                     Write-Host "`nDisk space module terminated."
                     return
              }
              
              "q"{
                    Write-Host "`nDisk space module terminated."
                    return
              }
    
              default {
                "Incorect character typed within the disk space module." | out-file -FilePath "D:\4CNS\Assignment2\Final Script\Script-Logs\errorlog.txt" -Append
                Write-Host "`nPlease enter a valid character`n"
              }
      }
   }

}