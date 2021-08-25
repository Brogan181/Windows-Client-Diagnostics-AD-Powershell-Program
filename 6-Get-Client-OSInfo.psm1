function remoteClientInfo {

<#
James Brogan

24/08/2021

This module retreives information from clients on a local network.
Information such as a clients OS System info, Bios Version and 
Computer Name can be collected.  

To use this module it first must be initiated by the mainProgram.
This can be done by selecting "6" at the main program menu.
Once initiated the module will ask whether the user wants to
request information from a local client.  If "yes" or "y" are 
detected, the module will ask the user for the clients hostname.
The module will show another menu that allows the user to select 
the information they wish to request.  After the user makes a 
selection, the desired information is requested from the remote
client and printed to the screen.
#>

  function secondSysInfoMenu {
" 
===================( System Information )=================== 
|                                                          |
|                                                          |
|   Please type a character to select from the following:  |
|                                                          |
|                                                          |
|==========================================================|                                             
|                                                          |
|   Type 'c' to:   Continue                                |
|                                                          |
|   Type 'q' to:   Quit Program                            |
|                                                          |
------------------------------------------------------------ 
"
  }

# This error displays if an error occurs on the first menu

  function errorDisplay0 {
"    
Please enter a valid character.

An error has occured. Error Code: 1
      
View the log error file for more information.

File path: D:\4CNS\Assignment2\Final Script\Script-Logs\errorlog.txt 
"
  }

# This error displays if an error occurs on the second menu

  function errorDisplay1 {
"    
Please enter a valid character.

An error has occured. Error Code: 2
      
View the log error file for more information.

File path: D:\4CNS\Assignment2\Final Script\Script-Logs\errorlog.txt 
"
  }

function systemInformationProgram {
    
    $errorCount = 0
    
    While($selection -ne "q") {
    
      $endLog = "`nProgram Stopped.`n`n$errorCount error(s) occured during this session.`n`nView the log error file for more information.`n`nFile path: D:\4CNS\Assignment2\Final Script\Script-Logserrorlog.txt`n"                
    
      sysInfoMenu
    
      # The user is prompted to type in a number, the number they type will depend on what information they wish to learn about the workstation.
                         
      Switch ($selection = Read-Host -Prompt "SELECTION") {
            "1"{Invoke-Command -ComputerName "$clientRemoteSelection" -ScriptBlock {Get-ComputerInfo OsName | Format-Table}}
            "2"{Invoke-Command -ComputerName "$clientRemoteSelection" -ScriptBlock {Get-ComputerInfo OsType | Format-Table}}
            "3"{Invoke-Command -ComputerName "$clientRemoteSelection" -ScriptBlock {Get-ComputerInfo OsArchitecture | Format-Table}}
            "4"{Invoke-Command -ComputerName "$clientRemoteSelection" -ScriptBlock {Get-ComputerInfo OsVersion | Format-Table}}
            "5"{Invoke-Command -ComputerName "$clientRemoteSelection" -ScriptBlock {Get-ComputerInfo BiosVersion | Format-Table}}
            "6"{Invoke-Command -ComputerName "$clientRemoteSelection" -ScriptBlock {Get-ComputerInfo CsManufacturer | Format-Table}}
            "7"{Invoke-Command -ComputerName "$clientRemoteSelection" -ScriptBlock {Get-ComputerInfo CsName | Format-Table}}
            "8"{Invoke-Command -ComputerName "$clientRemoteSelection" -ScriptBlock {Get-ComputerInfo CsDomain | Format-Table}}
            "9"{Invoke-Command -ComputerName "$clientRemoteSelection" -ScriptBlock {Get-ComputerInfo CsModel | Format-Table}}
            "10"{Invoke-Command -ComputerName "$clientRemoteSelection" -ScriptBlock {Get-ComputerInfo CsUserName | Format-Table}}
            "11"{Invoke-Command -ComputerName "$clientRemoteSelection" -ScriptBlock {Get-ComputerInfo OsCurrentTimeZone | Format-Table}}
            "q"{Write-Host $endLog
             return
                }          
            default {
                 Write-Host (errorDisplay0)
                   "Error code 1:  Incorect character typed on second selection menu" | out-file -FilePath "D:\4CNS\Assignment2\Final Script\Script-Logs\errorlog.txt" -Append
                      $errorCount++
                    }
       }
        
         # Start-Sleep is used to give the user sufficent time to read the selected output before new information is output.
    
         Start-Sleep -Seconds 2
    
         secondSysInfoMenu
      
         Switch ($selection = Read-Host -Prompt "SELECTION") {
             "c" {Write-Host "`nContinuing..." | Start-Sleep -Seconds 2} 
             "q" {Write-Host $endLog}
             default {
                       Write-Host (errorDisplay1)
                       "Error code 2:  Incorect character typed in the check remote client info module" | out-file -FilePath "D:\4CNS\Assignment2\Final Script\Script-Logs\errorlog.txt" -Append
                       $errorCount++
                     }
         }     
    }
}

  function cliInfoMsg {
"
 =========================================
|      Retreive Remote Client Info        |
 =========================================
| by James Brogan   | Created: 5/08/2021  |
 =========================================

********************************************
 Warning! This module must be run in with 
 Administrator privelages.

"
  }

  function sysInfoMenu {
"    
===================( System Information )=================== 
|                                                          |
|                                                          |
|   Please type a character to select from the following:  |
|                                                          |
|                                                          |
|   Type 1  for:  OS System                                |
|                                                          |
|   Type 2  for:  OS Type                                  |
|                                                          |
|   Type 3  for:  OS Architecture                          |
|                                                          |
|   Type 4  for:  OS Version                               |
|                                                          |
|   Type 5  for:  Bios Version                             |
|                                                          |
|   Type 6  for:  Computer Brand                           |
|                                                          |
|   Type 7  for:  Computer Name                            |
|                                                          |
|   Type 8  for:  Current Domain                           |
|                                                          |
|   Type 9  for:  Computer Model                           |
|                                                          |
|   Type 10 for:  Current User                             |
|                                                          |
|   Type 11 for:  Timezone                                 |
|                                                          |
|==========================================================|  
|                                                          |
|               Type 'q' to:  Quit Program                 |
|                                                          |
------------------------------------------------------------
"
  }
  
  function addTrustedHost {
  
    Switch ($startClientInfoSession = Read-Host -Prompt "`nDo you wish to connect to a remote client and receive its system info? Y/N") {
            
            "y"{
                cliInfoMsg

    $clientRemoteSelection = Read-Host -Prompt "`nEnter client IP address e.g. 192.168.2.32, or enter the client's hostname"
  
    Set-Item "WSMan:\localhost\Client\TrustedHosts" -Value "$clientRemoteSelection"
    
    $conectionTest = Test-Connection -ComputerName "$clientRemoteSelection" -Quiet -count 2
    
     
    If ($conectionTest -ne ""){
      systemInformationProgram   
    }
    Else{
      Write-Host "$clientRemoteSelection is offline, enter a different hostname and try again" | out-file -FilePath "D:\4CNS\Assignment2\Final Script\Script-Logs\errorlog.txt" -Append
      return
     }
            }

            "yes"{
                cliInfoMsg

    $clientRemoteSelection = Read-Host -Prompt "`nEnter client IP address e.g. 192.168.2.32, or enter the client's hostname"
  
    Set-Item "WSMan:\localhost\Client\TrustedHosts" -Value "$clientRemoteSelection"
    
    $conectionTest = Test-Connection -ComputerName "$clientRemoteSelection" -Quiet -count 2
    
     
    If ($conectionTest -ne ""){
      systemInformationProgram   
    }
    Else{
      Write-Host "$clientRemoteSelection is offline, enter a different hostname and try again" | out-file -FilePath "D:\4CNS\Assignment2\Final Script\Script-Logs\errorlog.txt" -Append
      return
     }
            }

            "n"{
                  Write-Host "`nRemote client info module terminated."
                  return
               }

            "no"{
                   Write-Host "`nRemote client info module terminated."
                   return
            }

            "q"{
                  Write-Host "`nRemote client info module terminated."
                  return
               }          
            default {
                       Write-Host (errorDisplay1)
                       "Error code 2:  Incorect character typed in the check remote client info module" | out-file -FilePath "D:\4CNS\Assignment2\Final Script\Script-Logs\errorlog.txt" -Append
                       $errorCount++
                    }
                    }

 
    }

addTrustedHost

  }

  
