@echo off

setlocal
chcp 65001 >nul


:banner
echo  __ __ _     _   _ _____                 _       _ 
echo ^|  ^|  ^|_^|___^| ^|_^| ^| __  ^|___ _ _ ___ ___^| ^|___ _^| ^|
echo ^|_   _^| ^| -_^| ^| . ^|    -^| -_^| ^| ^| -_^| .'^| ^| -_^| . ^|
echo   ^|_^| ^|_^|___^|_^|___^|__^|__^|___^|\_/^|___^|__,^|_^|___^|___^|
echo                      by CodeLao
echo                   ~~~ Installer ~~~


set INSTALL_DIR="%SystemDrive%\Program Files\Yield Revealed"


:banner


call :info "Verifying dependencies..."

where.exe node >nul 2>&1 && where.exe npm >nul 2>&1 || (
    set "ERR_MSG=Node.js / npm is not installed or not working properly."
    goto :error
)

where.exe python >nul 2>&1 || (
    set "ERR_MSG=Python is not installed or not working properly."
    goto :error
)


call :info "Creating Python virtual environment..."

cd /d %INSTALL_DIR% || (
    set "ERR_MSG=Failed to access application directory."
    goto :error
)

python -m venv .venv >nul 2>&1
if not exist ".venv\Scripts\python.exe" (
    set "ERR_MSG=Failed to create Python virtual environment."
    goto :error
)


call :info "Installing Python dependencies..."

.venv\Scripts\python.exe -m pip install --upgrade pip >nul 2>&1
.venv\Scripts\python.exe -m pip install -r requirements.txt >nul 2>&1 || (
    set "ERR_MSG=Failed to install Python dependencies."
    goto :error
)


call :info "Installing Node.js dependencies..."

call npm ci --no-audit --no-fund >nul 2>&1 || (
    set "ERR_MSG=Failed to install Node.js dependencies."
    goto :error
)


exit /b 0


:error
>&2 echo [ERROR] %ERR_MSG%
exit /b 1

:info
echo [INFO] %~1
goto :eof
