function viewSecurityLog {

<#
James Brogan

24/08/2021

This module opens an html document that contains the 20 most
recent log entries from a security log.  

To use this module it first must be initiated by the mainProgram.
This can be done by selecting "7" at the main program menu.
The module will prompt the user to determine whether they wish
to open the security log in a html document.  If "yes" or "y"
is detected the program copies the top 20 lines from the security
log into the html document.  
#>

function svrSecMsg {
"
 =========================================
| View Latest Security Logs On a Webpage  |
 =========================================
| by James Brogan   | Created: 3/08/2021  |
 =========================================
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

  function errorDisplay1 {
"    
The HTML file is already created.

An error has occured.
      
View the log error file for more information.

File path: D:\4CNS\Assignment2\Final Script\Script-Logs\errorlog.txt 
"
  }

  function securityLogMenu {
"
|==========================================================|
|                                                          |
|         Do you want to view the 20 most recent           |
|         records in the server's security log?            |
|                                                          |               
|                       Y / N                              |
|                                                          |
|==========================================================|
"
    }
   
  While ($logMenuSelection -ne "n","no") {
  
  $endLog = "`nCheck Security Log Session Terminated."
  
  svrSecMsg

  securityLogMenu

  function getLog {
  $receiveLog = Get-Content "G:\4CNS\Assignment2\Final Script\Script-Logs\securitylog.txt" | select -First 20 | Out-File "G:\4CNS\Assignment2\Final Script\Script-Logs\securitylogtop20.txt"
  }

  Switch ($logMenuSelection = Read-Host -Prompt "Selection") {
        "y"   {getLog}
        "yes" {getLog}
        "n"   {Write-Host $endLog
               return}
        "no"  {Write-Host $endLog
               return}
        default {errorDisplay0
        "Incorect character typed in the Security Log Program" | out-file -FilePath "G:\4CNS\Assignment2\Final Script\Script-Logs\errorlog.txt" -Append
        }
  }           
 
 function createHtml {
    
    $htmlexists = Test-Path -Path "G:\4CNS\Assignment2\Final Script\Script\securityLog.html" -PathType Leaf
    
    $htmlexists
    
    If ($htmlexists = "False"){
    
     $createHtml = New-Item "G:\4CNS\Assignment2\Final Script\Script-Logs\securityLog.html" -ItemType File 
      '<!DOCTYPE html>
      <html lang="en">
        <head>
          <meta charset="utf-8"/>
          <title>FoxIT Car Parts Security Log</title>
      	<style>
      	body {
      	font-family: calibri
      	}
      	</style>
        </head>
        
        <body>
      <h3 style="text-align:center;">FoxIT Car Parts<h3>
      <h1 style="text-align:center;">Security Log<h1>
      
      <p style=`"text-align:center;`"> <iframe frameBorder="0" width=2000 height="2000" src="securitylogtop20.txt"; style="text-align:center;">
      </iframe></p>
      
        </body>
      
      </html>' | out-file -FilePath "G:\4CNS\Assignment2\Final Script\Script-Logs\securityLog.html" -Append
           
    }
    
    elseif ($htmlexists = "True"){errorDisplay1
          "The Html file already exists" | out-file -FilePath "G:\4CNS\Assignment2\Final Script\Script-Logs\errorlog.txt" -Append
          return
    }
    
  }
  
    createHtml
     
    Invoke-Item "G:\4CNS\Assignment2\Final Script\Script-Logs\securityLog.html"
  
    Write-Host "`nLog website opened."

    }
}