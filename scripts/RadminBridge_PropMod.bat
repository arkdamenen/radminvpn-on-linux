::The script to enable or disable promiscuous mode on Radmin or any other interfaces.
::As mentioned, sometimes it is needed in order to function.
::Usually it is enough to enable it only on Radmin interface.
@echo off

:Choice
choice /C:YNE /M:"Do you want to enable [Y], disable [N] the promiscuous mode on any of interfaces or end the script [E]?"
::Y = Errolevel = 1, go to enabling section
::N = Errolevel = 2, go to disabling section
::E = Errolevel = 3, end
IF %ERRORLEVEL% ==1 GOTO EnablePropMode
IF %ERRORLEVEL% ==2 GOTO DisablePropMode
GOTO End

:EnablePropMode
::Show adapters in bridge, their IDs and their promiscuous mode state.
netsh bridge show adapter

set /p rvID=What ID do you want to enable promiscuous  mode on?

::Enable promiscuous  mode on user entered interface.
netsh bridge set adapter %rvID% forcecompatmode=enable

::Ask user to check if everything is correct, then send them to the beginning of the script (the Choice).
netsh bridge show adapter
echo Check please, if ForceCompatibilityMode is enabled where it is needed.

GOTO Choice


:DisablePropMode
::Show adapters in bridge, their IDs and their promiscuous mode state.
netsh bridge show adapter

set /p rvID=What ID do you want to disable promiscuous  mode on? 

::Disable promiscuous  mode on user entered interface.
netsh bridge set adapter %rvID% forcecompatmode=disable

::Ask user to check if everything is correct, then send them to the beginning of the script (the Choice).
netsh bridge show adapter
echo Check please, if ForceCompatibilityMode is enabled/disabled where is needed.

GOTO Choice

:End
echo. & echo Ending script.
pause