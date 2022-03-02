:: CHANGE PATH HERE
:: %userprofile% is path to your user folder in C:/user/
set SDKPATH="%userprofile%\Documents\PlaydateSDK"

@echo off
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

:: Add PLAYDATE_SDK_PATH env variable
setx /M PLAYDATE_SDK_PATH "%SDKPATH%"
:: Add pcd.exe to the PATH env variable
set pathkey="HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment"
for %%p in (pdc.exe) do (set pdcCheck=%%~$PATH:p)
if not defined pdcCheck (
   for /F "usebackq skip=2 tokens=2*" %%A IN (`reg query %pathkey% /v Path`) do (reg add %pathkey% /f /v Path /t REG_SZ /d "%%B;%SDKPATH%\bin")
)
:: Update register
powershell -command "& {$md=\"[DllImport(`\"user32.dll\"\",SetLastError=true,CharSet=CharSet.Auto)]public static extern IntPtr SendMessageTimeout(IntPtr hWnd,uint Msg,UIntPtr wParam,string lParam,uint fuFlags,uint uTimeout,out UIntPtr lpdwResult);\"; $sm=Add-Type -MemberDefinition $md -Name NativeMethods -Namespace Win32 -PassThru;$result=[uintptr]::zero;$sm::SendMessageTimeout(0xffff,0x001A,[uintptr]::Zero,\"Environment\",2,5000,[ref]$result)}"
echo SUCCESS!
pause
exit