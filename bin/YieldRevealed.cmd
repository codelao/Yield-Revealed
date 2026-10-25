@echo off

set "AppDir=%ProgramFiles%\Yield Revealed"
cd /d "%AppDir%" || (echo Yield Revealed folder not found at %ProgramFiles% & pause & exit /b 1)

node server.js
