@echo off
set target=%1

if "%target%"=="" (
    echo Usage: merge_symbols.bat target
    echo Example: merge_symbols.bat myapp
    exit /b 1
)
if not exist "%target%" (
    echo Error: Target folder "%target%" does not exist.
    exit /b 1
)
echo Target folder: %target%
pip3 list | find "kicad-symbol-merge" >nul
if errorlevel 1 (
    echo Installing kicad-symbol-merge...
    pip3 install kicad-symbol-merge
)
REM delete old merged symbol if it exists
if exist "%target%\%target%.kicad_sym" (
    del "%target%\%target%.kicad_sym"
)
REM run the merge command
kicad-symbol-merge "%target%" "%target%\%target%.kicad_sym"