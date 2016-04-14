@echo off
::-----------------------------------------------------------
:: PREPARE
::-----------------------------------------------------------
setlocal enableextensions enabledelayedexpansion

::-----------------------------------------------------------
:: DESCRIPTION
::-----------------------------------------------------------
:: Generate GUID and copying it to the clipboard.

::-----------------------------------------------------------
:: HISTORY VERSION
::-----------------------------------------------------------
set version=1.1.0
set version=%version: =%

::-----------------------------------------------------------
:: TITLE
::-----------------------------------------------------------
chcp 1251 >nul
set title=%~n0 - v%version%
chcp 866 >nul
cls
TITLE %title%

::-----------------------------------------------------------
:: MAIN
::-----------------------------------------------------------
goto MAIN

::-----------------------------------------------------------
:: Functions
::-----------------------------------------------------------
:MAIN
  call :NEW_GUID
  set new_guid=%NEW_GUID%
  @echo %new_guid% (copy to clipboard)
  @echo|set /p=%new_guid%| clip
goto EXIT

::-----------------------------------------------------------
:NEW_GUID
  setlocal enableextensions enabledelayedexpansion
  set result=%~0
  set hex=0123456789ABCDEF
  set /a x=1
  @echo %random%> nul
  
  :create_digit
    set /a dec=16*%random%/32768
    call :getX %%hex:~^%dec%,1%%
    set /a x+=1
    if %x% EQU 32 goto :got32
    goto :create_digit

    :getX
      set digits=%digits%%1
    goto :eof

    :got32
      set guid=%digits:~0,8%-%digits:~8,4%-%digits:~12,4%-%digits:~16,4%-%digits:~20,12%
  endlocal & set %result:~1%=%guid%
goto :EOF
::-----------------------------------------------------------
:EXIT
  endlocal
  pause

::-----------------------------------------------------------