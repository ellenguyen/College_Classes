@ECHO off
:: Use SQL*Plus to run the create_ar.sql script
SQLPLUS system/system @create_ar

:: Display a message about the log file
ECHO.
ECHO The create_ar.bat file has finished running.
ECHO.

:: Display 'press any key to continue' message
PAUSE