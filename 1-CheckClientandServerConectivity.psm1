function svrCliConnect {

<#
James Brogan

24/08/2021

This module checks the conection status of clients on a local network.
A text file stores each of the hostnames that will be used in this
test.  A client on each line of the text file is tested for conectivity.

To use this module it first must be initiated by the mainProgram.
This can be done by selecting "1" at the main program menu.
Once initiated the module will ask whether the user wants to
start the connection test.  If "yes" or "y" are detected,
the connection test will begin.  Live hosts will be printed
to the screen.
#>

  function svrCliConMsg {
"
 =========================================
| Server / Client Connection Check Module |
 =========================================
| by James Brogan   | Created: 3/08/2021  |
 =========================================
"
  }  

  function svrConectionEndMsg {
"
Server Connectivity Check Session Terminated.
"
  }   
  
  function errorDisplay0 {
"    

An error has occured.
      
View the log error file for more information.

File path: D:\4CNS\Assignment2\Final Script\Script-Logs\errorlog.txt 
"
  }   

    While ($conectivity -ne "n") {

      svrCliConMsg

      $clients = Get-Content 'D:\4CNS\Assignment2\Final Script\Script-Logs\clients.txt'
                     
        Switch ($conectivity = Read-Host -Prompt "Start Detection? Y/N")
          {
            "y" {foreach ($client in $clients) 
            {if(-not(Test-Connection -ComputerName $client -Quiet -count 1))
            {Write-Host "$client is offline" >>'D:\4CNS\Assignment2\Final Script\Script-Logs\unreachables.txt'}
             else{Write-Host "$client is online"}}
            
            Write-Host "`nCheck the unreachables.txt log to see offline clients."
          }
           "yes" {foreach ($client in $clients) 
            {if(-not(Test-Connection -ComputerName $client -Quiet -count 1))
            {Write-Host "$client is offline" >>'D:\4CNS\Assignment2\Final Script\Script-Logs\unreachables.txt'}
             else{Write-Host "$client is online"}}
            
            Write-Host "`nCheck the unreachables.txt log to see offline clients."
          }
            "n"{svrConectionEndMsg
             return
          }
          "no"{svrConectionEndMsg
             return
          }
             default {errorDisplay0
             "Incorect character typed within the server connection module." | out-file -FilePath "D:\4CNS\Assignment2\Final Script\Script-Logs\errorlog.txt" -Append
             Write-Host "Please enter a valid character."
          }
   }           

}

}
