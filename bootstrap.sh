#!/usr/bin/env sh

OS=$(uname -s | sed 's/^MINGW.*/windows/' | tr '[:upper:]' '[:lower:]')
ARCH="$(uname -m)"
TMPDIR=""

# Performs cleanup for this script
cleanup() {
    [ -d "$TMPDIR" ] && rm -rf "$TMPDIR"
}

# Forwards a captured interrupt (from a command) to the script itself
interrupt() {
    # Re-enable the default action and re-send the signal to self
    # to ensure the script terminates properly.
    trap - INT
    kill -INT "$$"
}

# Outputs a stylized prompt
prompt() {
    echo "$("$GUM" style --border rounded --padding "1 2" \
        "$("$GUM" join --align center --vertical \
            "$1" \
            "$("$GUM" style --faint "$2")" \
        )"
    )"
}

# Captures interrupts after prompts
afterprompt() {
    if [ $1 -ge 128 ]
    then interrupt; 
    else clear;
    fi
}

# Clean up on exit or interruption
trap cleanup EXIT 
trap interrupt INT

# Install Gum if it's not present
GUM=""
if ! command -v "gum" >/dev/null 2>&1
then
    # Determine download URL
    GUM_VERSION="0.17.0"
    GUM_ARCHIVE="gum_${GUM_VERSION}_${OS}_${ARCH}"
    GUM_URL="https://github.com/charmbracelet/gum/releases/download/v${GUM_VERSION}/${GUM_ARCHIVE}.tar.gz"
    
    # Make a temporary directory
    TMPDIR="$(mktemp -d)"
    echo "Temporary directory created at $TMPDIR"

    # Download and extract Gum
    echo "Downloading Gum from ${GUM_URL}..."
    curl -fSL "$GUM_URL" | tar -xz -C "$TMPDIR"
    echo "Gum downloaded and extracted."

    # Set Gum path and clean up
    GUM="$TMPDIR/$GUM_ARCHIVE/gum"
    clear
else
    GUM=$(command -v "gum")
    echo "Gum executable detected at $GUM"
fi

# Prompt for security ring
prompt \
    " To what security ring does this machine belong?" \
    "Controls SSH, GPG, secrets, and other sensitive features."
RING="$("$GUM" choose "0 (Personal)" "1 (Internally Managed)" "2 (Externally Managed)" "3 (Ephemeral)")"
afterprompt $?
RING=$(echo "$RING" | sed 's/^\([[:digit:]]\).*/\1/')

# Linux distro detection
if [ "$OS" = "linux" ]
then
    OS_AUTODETECTED=""

    # Autodetection relies on /etc/os-release
    if [ -f /etc/os-release ] \
    && [ -r /etc/os-release ]
    then
        . /etc/os-release
        OS_NAME="running $PRETTY_NAME"
        OS_ICON=""

        # WSL detection
        if [ -f /proc/sys/kernel/osrelease ] \
        && [ -r /proc/sys/kernel/osrelease ] \
        && grep -qi "microsoft" /proc/sys/kernel/osrelease
        then
            OS="wsl"
            OS_NAME="$OS_NAME on WSL (Windows Subsystem for Linux)"
            OS_ICON=""

        # Autodetect steam deck
        elif [ $ID = "steamos" ] && [ -f "/usr/bin/steamos-session-select" ]
        then
            OS="deck"
            OS_NAME="a Steam Deck"
            OS_ICON=""
        fi

        # Confirm autodetected OS with the user
        prompt \
            "$OS_ICON Is this machine $OS_NAME?" \
            "This is a heuristic. If this is incorrect, you will be prompted to select the correct environment."
        "$GUM" confirm ""
        afterprompt $?
        OS_AUTODETECTED=$?
    fi

    if [ ! $OS_AUTODETECTED ]
    then
        prompt \
            " What environment is this Linux machine running in?" \
            "Each environment has different capabilities and limitations that must be accounted for."
        OS=$("$GUM" choose "Linux (Arch, Debian, Ubuntu...)" "WSL (Windows Subsystem for Linux)" "Deck (SteamOS)")
        afterprompt $?
        OS=$(echo "$OS" | sed 's/^\([[:alpha:]]\).*/\1/' | tr '[:upper:]' '[:lower:]')
    fi
fi

# Prompt for GUI support
prompt \
    " Is this a headless machine?" \
    "Gates GUI-specific features like fonts and themes."
"$GUM" confirm ""
GUI=$([ $? -eq 0 ] && echo 1 || echo 0)
afterprompt $?

# Debug output
clear
echo "Configuration Summary:"
echo "  Security Ring: $RING"
echo "  Operating System: $OS"
echo "  GUI Support: $([ $GUI -eq 0 ] && echo "Yes" || echo "No")"