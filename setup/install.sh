#!/usr/bin/env bash

set -eu

LINUX_INSTALL_DIR="$HOME/.local/share/Yield Revealed"
MACOS_INSTALL_DIR="$HOME/Applications/Yield Revealed"


banner() {                                              
    printf " __ __ _     _   _ _____                 _       _   \n"
    printf "|  |  |_|___| |_| | __  |___ _ _ ___ ___| |___ _| |  \n"
    printf "|_   _| | -_| | . |    -| -_| | | -_| .'| | -_| . |  \n"
    printf "  |_| |_|___|_|___|__|__|___|\_/|___|__,|_|___|___|  \n"
    printf "                     by CodeLao                      \n"
    printf "                  ~~~ Installer ~~~                  \n\n\n"  
}

error() {
    printf "\033[31m[ERROR]\033[0m %s\n" "$1" >&2
    exit 1
}

info() {
    printf "\033[33m[INFO]\033[0m %s\n" "$1"
}

success() {
    printf "\033[32m[SUCCESS]\033[0m\n"
    printf "Application installed to $INSTALL_DIR\n\n"
    printf "To start, run \033[34mYieldRevealed\033[0m\n"
    exit 0
}


if [ "$EUID" -eq 0 ]; then
    error "Installation must not be run as root."
fi


OS="$(uname -s)"
case $OS in
    Darwin)
        INSTALL_DIR=$MACOS_INSTALL_DIR
        ;;

    Linux)
        INSTALL_DIR=$LINUX_INSTALL_DIR
        ;;

    *)
        error "Unsupported operating system: $OS"
        ;;
esac


banner


if [ -e "$INSTALL_DIR" ]; then error "Installation directory already exists. Run unins.sh to uninstall the app."
fi


info "Verifying dependencies..."

if ! command -v git >/dev/null 2>&1; then error "Git is not installed or not working properly."
fi

if ! command -v node >/dev/null 2>&1 || ! command -v npm >/dev/null 2>&1; then error "Node.js / npm is not installed or not working properly."
fi

if ! command -v python >/dev/null 2>&1; then
    if ! command -v python3 >/dev/null 2>&1; then error "Python is not installed or not working properly."
    else pbin="python3"
    fi
else pbin="python"
fi


info "Cloning project repository..."

if ! git clone https://github.com/codelao/Yield-Revealed.git "$INSTALL_DIR" >/dev/null 2>&1; then error "Failed to clone repository."
fi
cd "$INSTALL_DIR"


info "Creating Python virtual environment..."

$pbin -m venv .venv >/dev/null 2>&1
if [ ! -f ".venv/bin/python" ]; then error "Failed to create Python virtual environment."
fi


info "Installing Python dependencies..."

if ! .venv/bin/$pbin -m pip install --upgrade pip >/dev/null 2>&1 || ! .venv/bin/$pbin -m pip install -r requirements.txt >/dev/null 2>&1; then
    error "Failed to install Python dependencies."
fi


info "Installing Node.js dependencies..."

if ! npm ci >/dev/null 2>&1; then error "Failed to install Node.js dependencies."
fi


info "Installing launcher..."

touch bin/YieldRevealed.sh
cat > bin/YieldRevealed.sh <<EOF
#!/usr/bin/env bash

AppDir="$INSTALL_DIR"
cd "\$AppDir"
export PYTHON_BIN="\$AppDir/.venv/bin/python"

exec node server.js
EOF
if ! sudo install -m 755 "$INSTALL_DIR/bin/YieldRevealed.sh" /usr/local/bin/YieldRevealed; then
    error "Unable to install the launcher. Please, check your system rights and try again."
fi


info "Cleaning up..."

mv "setup/unins.sh" .
rm -rf "setup"
rm -rf "tests"
rm -rf "bin"
rm -f "README.md"
rm -f ".gitignore"
rm -f "YieldRevealed.sh"


success
