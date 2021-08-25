  function newOrganisationalUnit {

<#
James Brogan

24/08/2021

This module creates new organisational units whitin microsoft active directory
on a windows server client.    

To use this module it first must be initiated by the mainProgram.
This can be done by selecting "3" at the main program menu.
The module will prompt the user to determine whether they wish
to create a new Organisational Unit on the current domain.
If "yes" or "y" is detected the module will prompt the user for a
organisational unit name.  Once entered the Organisational Unit will
be created.  
#>


 function orgUnitMsg {
"
 =========================================
|     Create New Orginisational Unit      |
 =========================================
| by James Brogan   | Created: 5/08/2021  |
 =========================================
"
  }

  orgUnitMsg
  
  While ($createOrgUnitPrompt -ne "n","no") {
  
    Switch ($createOrgUnitPrompt = Read-Host -Prompt "`nCreate a new Organisational Unit on the current domain? Y/N"){
              
            "y" {
                   $domainName = (Get-CimInstance -ClassName Win32_ComputerSystem).Domain
            }
             
            "yes" {
                     $domainName = (Get-CimInstance -ClassName Win32_ComputerSystem).Domain
            }
             
            "n"{
                  Write-Host "`nNew Organisational Unit module terminated."
                  return
            }
  
            "no"{
                   Write-Host "`nNew Organisational Unit module terminated."
                   return
            }
            
            "q"{
                  Write-Host "`nNew Organisational Unit module terminated."
                  return
            }
  
            default {
              "Incorect character typed within the server connection module." | out-file -FilePath "D:\4CNS\Assignment2\Final Script\Script-Logs\errorlog.txt" -Append
              Write-Host "Please enter a valid character"
            }
            }
      
    $domainNameFormatted1 = "DC=$domainName"
  
    $domainNameFormatted2 = $domainNameFormatted1.Replace("`.",",DC=")
  
    Write-Host $domainNameFormatted2
  
    $orginisationalUnitName = Read-Host -Prompt "`nWrite a New Organisational Unit Name"
     
    $checkExists = Get-ADOrganizationalUnit -Filter { Name -like $orginisationalUnitName}
  
    if ($checkExists -eq $null){
      
      New-ADOrganizationalUnit -Name "$orginisationalUnitName" -Path "$domainNameFormatted2" -ProtectedFromAccidentalDeletion $False
  
    }
  
    else {
    
      "Organisational Unit already exists." | out-file -FilePath "D:\4CNS\Assignment2\Final Script\Script-Logs\errorlog.txt" -Append
      
      Write-Host "`nThis Organisational Unit already exists.`nTry another.`n"
  
    }
  
   
      
    }

  }



  
