@echo off
title iBarangay - Database Initializer
echo =========================================================
echo              iBarangay Database Initializer
echo =========================================================
echo.
echo Database  : PPGG_projectdb
echo Username  : postgres
echo Port      : 5432
echo.

set PGPASSWORD=acads23
where psql >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo [ERROR] 'psql' command not found in your PATH.
    echo If PostgreSQL is installed, add its bin directory to PATH:
    echo e.g., C:\Program Files\PostgreSQL\16\bin
    echo.
    echo Or create database 'PPGG_projectdb' manually using pgAdmin.
    pause
    exit /b 1
)

echo Creating database 'PPGG_projectdb' if not exists...
psql -U postgres -h localhost -p 5432 -c "CREATE DATABASE \"PPGG_projectdb\";" 2>nul
if %ERRORLEVEL% equ 0 (
    echo [OK] Database created successfully!
) else (
    echo [INFO] Database might already exist or check connection settings.
)

pause
