@echo off
title iBarangay - Server Runner
echo Starting iBarangay Application...
echo http://localhost:8080/
echo.
call "%~dp0mvnw.cmd" spring-boot:run
if %ERRORLEVEL% neq 0 (
    echo.
    echo [ERROR] Application failed to start.
    pause
)
