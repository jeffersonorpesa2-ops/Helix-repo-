@echo off
setlocal enabledelayedexpansion
title iBarangay - Setup and Start

echo =========================================================
echo               iBarangay Application Setup
echo =========================================================
echo.

:: 1. Check Java Installation
echo [1/3] Checking Java installation...
where java >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Java is not detected in your PATH!
    echo Please install JDK 21 (or JDK 17+) and ensure JAVA_HOME is set.
    echo Download JDK from: https://adoptium.net/
    goto :error
)
java -version
echo [OK] Java detected.
echo.

:: 2. Check Database Setup
echo [2/3] Checking PostgreSQL database configuration...
echo Target Database : PPGG_projectdb
echo Target Port     : 5432
echo Target User     : postgres
echo.
echo Attempting to initialize PostgreSQL database if psql is available...
where psql >nul 2>nul
if %ERRORLEVEL% equ 0 (
    set PGPASSWORD=acads23
    psql -U postgres -h localhost -p 5432 -tc "SELECT 1 FROM pg_database WHERE datname = 'PPGG_projectdb'" | findstr "1" >nul 2>nul
    if !ERRORLEVEL! neq 0 (
        echo Database 'PPGG_projectdb' not found. Creating database...
        psql -U postgres -h localhost -p 5432 -c "CREATE DATABASE \"PPGG_projectdb\";"
        if !ERRORLEVEL! equ 0 (
            echo [OK] Database 'PPGG_projectdb' created successfully!
        ) else (
            echo [WARNING] Could not create database automatically.
            echo Please ensure PostgreSQL service is running on port 5432 and password is correct.
        )
    ) else (
        echo [OK] Database 'PPGG_projectdb' already exists.
    )
) else (
    echo [INFO] 'psql' CLI not detected in PATH.
    echo Please ensure PostgreSQL is running and database 'PPGG_projectdb' exists in pgAdmin.
)
echo.

:: 3. Build & Run Application
echo [3/3] Starting Spring Boot application via Maven Wrapper...
echo Application will be accessible at: http://localhost:8080
echo Press Ctrl+C in this terminal to stop the server.
echo.

call "%~dp0mvnw.cmd" spring-boot:run
if %ERRORLEVEL% neq 0 (
    goto :error
)

goto :end

:error
echo.
echo =========================================================
echo [FAILED] An error occurred during setup or startup.
echo Please review the logs above.
echo =========================================================
pause
exit /b 1

:end
pause
