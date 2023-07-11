:: SCCM All Actions ver. 2
:: tking251
:: For reference on the SMS_Client commands 
:: https://learn.microsoft.com/en-us/mem/configmgr/develop/reference/core/clients/client-classes/triggerschedule-method-in-class-sms_client

@echo off
setlocal enableextensions enabledelayedexpansion

rem Define the strings that will be echoed at different points in this script...
set WELCOME_MESSAGE=Tim's Magic SCCM Actions Script
set START_MESSAGE=Running SCCM Actions...
set EXIT_MESSAGE=SCCM Actions finished, starting Group Policy Update. It is now safe to remove USB.
set MESSAGE=Triggered

set TOTAL_COMMANDS=11
set PERCENTAGE_PER_COMMAND=100

rem Define the array of strings containing the names of the SCCM Actions
set "COMMAND[0]=Machine Policy Assignments Request"
set "COMMAND[1]=Machine Policy Evaluation"
set "COMMAND[2]=Data Discovery Record"
rem set "COMMAND[3]=Discovery Data Collection Cycle"
set "COMMAND[4]=Software Inventory"
rem set "COMMAND[5]=Software Inventory Collection Cycle"
set "COMMAND[6]=Hardware Inventory"
rem set "COMMAND[7]=Hardware Inventory Collection Cycle"
set "COMMAND[8]=Scan by Update Source"
set "COMMAND[9]=Update Store Policy"
set "COMMAND[10]=Software Metering Generating Usage Report"
set "COMMAND[11]=Application manager policy action"
set "COMMAND[12]=Source Update Message"
set "COMMAND[13]=File Collection"

echo %WELCOME_MESSAGE%
echo %START_MESSAGE%
  rem Run the WMIC command silently
  call :progressbar 0

  WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000021}" /NOINTERACTIVE >nul
  echo %MESSAGE% !COMMAND[0]!
  call :progressbar 9

  WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000022}" /NOINTERACTIVE >nul
  echo %MESSAGE% !COMMAND[1]!
  call :progressbar 18

  WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000003}" /NOINTERACTIVE >nul
  echo %MESSAGE% !COMMAND[2]!
  call :progressbar 27

  WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000002}" /NOINTERACTIVE >nul
  echo %MESSAGE% !COMMAND[4]!
  call :progressbar 36

  WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000001}" /NOINTERACTIVE >nul
  echo %MESSAGE% !COMMAND[6]!
  call :progressbar 45

  WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000113}" /NOINTERACTIVE >nul
  echo %MESSAGE% !COMMAND[8]!
  call :progressbar 54

  WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000114}" /NOINTERACTIVE >nul
  echo %MESSAGE% !COMMAND[9]!
  call :progressbar 63

  WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000031}" /NOINTERACTIVE >nul
  echo %MESSAGE% !COMMAND[10]!
  call :progressbar 72

  WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000121}" /NOINTERACTIVE >nul
  echo %MESSAGE% !COMMAND[11]!
  call :progressbar 81

  WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000032}" /NOINTERACTIVE >nul
  echo %MESSAGE% !COMMAND[12]!
  call :progressbar 91

  WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000010}" /NOINTERACTIVE >nul
  echo %MESSAGE% !COMMAND[13]!
  call :progressbar 100
)

echo:
echo %EXIT_MESSAGE%
gpupdate /force

:processmessage
set COMMAND_INDEX=1
echo Processing command !COMMAND_INDEX! of !TOTAL_COMMANDS!:
set COMMAND_INDEX+=1

:progressbar
set PERCENT=%1
set /A BARS=%PERCENT%/2
set /A SPACES=50-%Bars%
set METER=
for /L %%A IN (%BARS%,-1,1) DO SET METER=!METER!I
for /L %%A IN (%SPACES%,-1,1) DO SET METER=!METER! 
title Progress:  [%METER%]  %PERCENT%%%
endlocal