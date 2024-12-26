@echo off
TITLE Command Prompt
SET location="%~dp0"
echo.
echo  COPY bass.dll to C:\Windows
echo.
COPY %location%\bass.dll C:\Windows
echo.
PAUSE
