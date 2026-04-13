@echo off
chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion

:: Переход в целевую папку (если передан параметр)
if not "%1"=="" (
    cd /d "%1" 2>nul || ( echo Ошибка: папка "%1" не найдена & pause & exit /b )
)
echo Работаем в: %cd%

:: Получаем дату и время через PowerShell
for /f "delims=" %%i in ('powershell -Command "Get-Date -Format 'yyyy-MM-dd HH:mm'"') do set "datetime=%%i"
set "today=%datetime:~0,10%"
set "current_time=%datetime:~11,5%"

:: Рекурсивный обход всех папок
for /d /r %%d in (*) do (
    if not exist "%%d\%%~nxd.md" (
        echo Создаётся "%%d\%%~nxd.md"
        for %%p in ("%%d\..") do set "parent=%%~nxp"
        (
            echo %today% в %current_time%
            echo Теги:[[!parent!]]
            echo(
            echo ----
            echo(
        ) > "%%d\%%~nxd.md"
    )
)

:: Рекурсивный обход всех пустых .md файлов
for /f "delims=" %%f in ('dir /s /b *.md') do (
    if %%~zf equ 0 (
        for %%p in ("%%f\..") do set "parent=%%~nxp"
        echo Заполняется пустой "%%f" тегом [[!parent!]]
        (
            echo %today% в %current_time%
            echo Теги:[[!parent!]]
            echo(
            echo ----
            echo(
        ) > "%%f"
    )
)

echo Готово!
pause