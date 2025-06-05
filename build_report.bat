@echo off
setlocal enabledelayedexpansion

REM ───────────────────────────────
REM Check if arguments were passed
if "%~1"=="" (
    echo ERROR: No notebooks were specified as arguments.
    echo Usage: %~nx0 notebook1.ipynb notebook2.ipynb ...
    exit /b 1
)

REM Create output folder
mkdir latex 2>nul

REM Read arguments as notebooks
echo Arguments detected. Using provided notebooks...
set NOTEBOOKS=
:collect_args
if "%~1"=="" goto continue_script
set "NOTEBOOKS=!NOTEBOOKS! %~1"
shift
goto collect_args

:continue_script

REM 1. Merge notebooks
echo Merging notebooks...
nbmerge !NOTEBOOKS! --output latex\report.ipynb

REM 2. Convert to LaTeX
echo Generating LaTeX...
jupyter nbconvert latex\report.ipynb --to latex --output-dir=latex

REM 3. Replace header (if header.tex exists)
set TEXFILE=latex\report.tex
set HEADER=header.tex
set TMPFILE=latex\report_modificado.tex
set LINES=392

if exist "%HEADER%" (
    echo Replacing header with %HEADER%...
    powershell -Command ^
        "$header = Get-Content '%HEADER%';" ^
        "$body = Get-Content '%TEXFILE%' | Select-Object -Skip %LINES%;" ^
        "$header + $body | Set-Content '%TMPFILE%';"
    move /Y "%TMPFILE%" "%TEXFILE%" >nul
) else (
    echo %HEADER% not found. Keeping original header.
)

echo Done. File generated: %TEXFILE%
