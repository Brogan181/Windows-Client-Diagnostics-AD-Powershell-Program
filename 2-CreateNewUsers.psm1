function newADUsers {

<#
James Brogan

24/08/2021

This module creates new users whitin microsoft active directory
on a windows server client.    

To use this module it first must be initiated by the mainProgram.
This can be done by selecting "2" at the main program menu.
The module will prompt the user to determine whether they wish
to create a new user in active directory.  If "yes" or "y"
is detected the program will prompt the user to enter a username,
firstname, lastname and password.  After these parameters are entered
the user is created.  
#>

  function newADMsg {
"
 =========================================
|    Create New Active Directory Users    |
 =========================================
| by James Brogan   | Created: 5/08/2021  |
 =========================================
"
  }
 
  function newUsersErrorDisplay0 {
"    
User creation failed.
  
An error has occured.
        
View the log error file for more information.
  
File path: D:\4CNS\Assignment2\Final Script\Script-Logs\errorlog.txt 
"
  }
 
 function createUserMenu {
"
|==========================================================|
|                                                          |
|         Do you want to create a new user?                |
|                                                          |               
|                       Y / N                              |
|                                                          |
|==========================================================|
"
  }

function userNamePassInput {
      
      $adUserName = Read-Host -Prompt "`nEnter a username"

      $adFirstName = Read-Host -Prompt "`nEnter the users first name"

      $adLastName = Read-Host -Prompt "`nEnter the users last name"

      $adUserPassword = Read-Host -Prompt "`nEnter a secure password"

      If (Get-ADUser -Filter {SamAccountName -eq $adUserName}) {
      
        Write-Warning "`nAn account with the same name already exists. `nTry another username."

        "Failed to create user." | out-file -FilePath "D:\4CNS\Assignment2\Final Script\Script-Logs\errorlog.txt" -Append
            
      }

      else {
      
        New-ADUser -Name "$adUserName" -AccountPassword (ConvertTo-SecureString -AsPlainText $adUserPassword -Force) -GivenName "$adFirstName" -Surname "$adLastName" -SamAccountName "$adUserName"
       
        If (Get-ADUser -Filter {SamAccountName -eq $adUserName}) {
        
          Write-Host "`nThe user has been successfully created."
        
        }

        else {
        
          Write-Host "`nThe user was not created, try again."
        
        }

      }

}

function createUserPrompt {

     createUserMenu

     Switch ($createUserSelection = Read-Host -Prompt "Selection") {
          "y"   {
                  userNamePassInput
                }

          "yes" {
                  userNamePassInput
                }

          "n"   {
                   Write-Host "`nModule terminated."
                   return
                }

          "no"  {
                   Write-Host "`nModule terminated."
                   return

                }
          
          default {
                     newUsersErrorDisplay0
                     "Incorect character typed in the Create New AD User Module" | out-file -FilePath "D:\4CNS\Assignment2\Final Script\Script-Logs\errorlog.txt" -Append
                  }
          }
      }

  newADMsg

While ($createUserSelection -ne "n", "no", "q") {

  createUserPrompt

  return
    
}

}


