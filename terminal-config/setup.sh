#!/bin/sh
#  ████████╗███████╗██████╗ ███╗   ███╗██╗███╗   ██╗ █████╗ ██╗
#  ╚══██╔══╝██╔════╝██╔══██╗████╗ ████║██║████╗  ██║██╔══██╗██║
#     ██║   █████╗  ██████╔╝██╔████╔██║██║██╔██╗ ██║███████║██║
#     ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██║██║╚██╗██║██╔══██║██║
#     ██║   ███████╗██║  ██║██║ ╚═╝ ██║██║██║ ╚████║██║  ██║███████╗
#     ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝
#
#   Script to install the decoupled Terminal configuration (Zsh, Alacritty, Kitty)
#   Created from gh0stzk/dotfiles.
#

# Colors
CRE=$(tput setaf 1)    # Red
CYE=$(tput setaf 3)    # Yellow
CGR=$(tput setaf 2)    # Green
CBL=$(tput setaf 4)    # Blue
CMG=$(tput setaf 5)    # Magenta
CCN=$(tput setaf 6)    # Cyan
BLD=$(tput bold)       # Bold
CNC=$(tput sgr0)       # Reset colors

# Logo
logo() {
    text="$1"
    printf "%b" "
    ${BLD}${CCN}  ______                   _             _ 
    ${BLD}${CCN} /_  __/___  ________ ___ (_)___  ____ _/ / 
    ${BLD}${CCN}  / / / _ \\/ ___/ __ \`__ \\/ / __ \\/ __ \`/ /  
    ${BLD}${CCN} / / /  __/ /  / / / / / / / / / / /_/ / /   
    ${BLD}${CCN}/_/  \\___/_/  /_/ /_/ /_/_/_/ /_/\\__,_/_/    
    
    ${BLD}${CCN}       [ ${CYE}${text} ${CCN}]${CNC}\n\n"
}

# Initial Checks
initial_checks() {
    # Check if run as root
    if [ "$(id -u)" = 0 ]; then
        printf "%b\n" "${BLD}${CRE}Error: This script MUST NOT be run as root user.${CNC}"
        exit 1
    fi
}

welcome() {
    clear
    logo "Terminal Setup"

    printf "%b" "${BLD}${CGR}This script will install a premium, decoupled terminal environment:${CNC}

  ${BLD}${CCN}[${CYE}1${CCN}]${CNC} ${BLD}Emulators:${CNC} Alacritty & Kitty configurations (Fonts, Themes, Padding).
  ${BLD}${CCN}[${CYE}2${CCN}]${CNC} ${BLD}Shell:${CNC} Zsh configuration (.zshrc) with autocompletion, fzf-tab, and aliases.
  ${BLD}${CCN}[${CYE}3${CCN}]${CNC} ${BLD}Features:${CNC} Autosuggestions, syntax highlighting, fzf file previews.
  ${BLD}${CCN}[${CYE}4${CCN}]${CNC} ${BLD}Utilities:${CNC} Standalone 'colorscript' for terminal startup banners.

  ${BLD}${CRE}Note:${CNC} Existing configurations will be backed up safely to ${CBL}~/.terminal_config_backup/${CNC}
  ${BLD}${CRE}System:${CNC} Automatic dependency installation is supported for Arch Linux systems.

"

    while :; do
        printf " %b" "${BLD}${CGR}Do you wish to continue?${CNC} [y/N]: "
        read -r yn
        case "$yn" in
            [Yy])
                break ;;
            [Nn]|"")
                printf "\n%b\n" "${BLD}${CYE}Operation cancelled.${CNC}"
                exit 0 ;;
            *)
                printf "\n%b\n" "${BLD}${CRE}Error:${CNC} Please enter '${BLD}${CYE}y${CNC}' or '${BLD}${CYE}n${CNC}'" ;;
        esac
    done
}

install_dependencies() {
    clear
    logo "Dependencies"
    
    # Check if pacman is available (Arch Linux)
    if ! command -v pacman >/dev/null 2>&1; then
        printf "%b\n" "${BLD}${CYE}Non-Arch system detected or pacman not found.${CNC}"
        printf "%b\n" "Please make sure to install the following packages manually:"
        printf "%b\n\n" "${BLD}${CCN}zsh alacritty kitty eza bat fzf zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search ttf-jetbrains-mono-nerd fzf-tab-git${CNC}"
        
        while :; do
            printf "%b" "${BLD}${CYE}Do you want to proceed with config installation?${CNC} [y/N]: "
            read -r proceed
            case "$proceed" in
                [Yy]) return 0 ;;
                [Nn]|"") exit 0 ;;
            esac
        done
    fi

    # Arch Linux detected
    printf "%b\n" "${BLD}${CCN}Arch Linux system detected.${CNC}"
    while :; do
        printf "%b" "${BLD}${CYE}Do you want to install/upgrade the terminal dependencies via pacman/AUR?${CNC} [y/N]: "
        read -r inst_dep
        case "$inst_dep" in
            [Yy]) inst_dep="y"; break ;;
            [Nn]|"") inst_dep="n"; break ;;
        esac
    done

    if [ "$inst_dep" = "y" ]; then
        printf "\n%b\n" "${BLD}${CYE}Updating package database and installing official packages...${CNC}"
        sudo pacman -Syy
        
        official_deps="alacritty kitty zsh eza bat fzf zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search ttf-jetbrains-mono-nerd"
        sudo pacman -S --needed --noconfirm $official_deps

        # Try to install AUR dependency (fzf-tab-git)
        printf "\n%b\n" "${BLD}${CYE}Checking for AUR helpers to install fzf-tab-git...${CNC}"
        if command -v paru >/dev/null 2>&1; then
            paru -S --needed --noconfirm fzf-tab-git
        elif command -v yay >/dev/null 2>&1; then
            yay -S --needed --noconfirm fzf-tab-git
        else
            printf "%b\n" "${BLD}${CRE}Warning: No AUR helper (paru or yay) found.${CNC}"
            printf "%b\n" "Please install ${BLD}${CCN}fzf-tab-git${CNC} manually from AUR for Zsh completion previews to work."
            sleep 3
        fi
    fi
}

backup_configs() {
    clear
    logo "Backup Configs"
    
    # Define backup folder with timestamp
    backup_folder="$HOME/.terminal_config_backup/$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$backup_folder"
    printf "%b\n\n" "${BLD}${CYE}Backing up existing configurations to: ${CBL}$backup_folder${CNC}"
    sleep 1

    # Backup folders in ~/.config
    cfg_dirs="alacritty kitty zsh"
    for dir in $cfg_dirs; do
        if [ -d "$HOME/.config/$dir" ]; then
            printf "Backing up ~/.config/%s ...\n" "$dir"
            mv "$HOME/.config/$dir" "$backup_folder/"
        fi
    done

    # Backup Zshrc in HOME
    if [ -f "$HOME/.zshrc" ]; then
        printf "Backing up ~/.zshrc ...\n"
        mv "$HOME/.zshrc" "$backup_folder/"
    fi

    # Backup colorscript in local bin
    if [ -f "$HOME/.local/bin/colorscript" ]; then
        printf "Backing up ~/.local/bin/colorscript ...\n"
        mkdir -p "$backup_folder/bin"
        mv "$HOME/.local/bin/colorscript" "$backup_folder/bin/"
    fi

    printf "\n%b\n" "${BLD}${CGR}Backup complete!${CNC}"
    sleep 2
}

install_configs() {
    clear
    logo "Installing Configs"
    
    # Get the directory of the active setup.sh script
    SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
    
    printf "%b\n\n" "${BLD}${CYE}Copying terminal configurations from: ${CBL}$SCRIPT_DIR${CNC}"
    sleep 1

    # Create target directories if they don't exist
    mkdir -p "$HOME/.config"
    mkdir -p "$HOME/.local/bin"
    mkdir -p "$HOME/.config/zsh"

    # Copy Alacritty configurations
    if [ -d "$SCRIPT_DIR/config/alacritty" ]; then
        printf "Copying Alacritty configuration...\n"
        cp -R "$SCRIPT_DIR/config/alacritty" "$HOME/.config/"
    fi

    # Copy Kitty configurations
    if [ -d "$SCRIPT_DIR/config/kitty" ]; then
        printf "Copying Kitty configuration...\n"
        cp -R "$SCRIPT_DIR/config/kitty" "$HOME/.config/"
    fi

    # Copy Zsh configurations (.zshrc)
    if [ -f "$SCRIPT_DIR/home/.zshrc" ]; then
        printf "Copying Zsh configuration (.zshrc)...\n"
        cp "$SCRIPT_DIR/home/.zshrc" "$HOME/.zshrc"
    fi

    # Copy colorscript utility
    if [ -f "$SCRIPT_DIR/bin/colorscript" ]; then
        printf "Copying colorscript startup utility...\n"
        cp "$SCRIPT_DIR/bin/colorscript" "$HOME/.local/bin/colorscript"
        chmod +x "$HOME/.local/bin/colorscript"
    fi

    # Reload fonts cache
    if command -v fc-cache >/dev/null 2>&1; then
        printf "Rebuilding font cache...\n"
        fc-cache -f >/dev/null 2>&1
    fi

    printf "\n%b\n" "${BLD}${CGR}Terminal configurations installed successfully!${CNC}"
    sleep 2
}

set_default_shell() {
    clear
    logo "Default Shell"
    
    zsh_path=$(command -v zsh)
    if [ -z "$zsh_path" ]; then
        printf "%b\n\n" "${BLD}${CRE}Warning: Zsh is not installed. Shell change skipped.${CNC}"
        sleep 2
        return 0
    fi

    # Check if default shell is already zsh
    if [ "$SHELL" = "$zsh_path" ]; then
        printf "%b\n\n" "${BLD}${CGR}Zsh is already your default shell!${CNC}"
        sleep 2
        return 0
    fi

    while :; do
        printf "%b" "${BLD}${CYE}Do you want to make Zsh your default shell?${CNC} [y/N]: "
        read -r ch_shell
        case "$ch_shell" in
            [Yy]) ch_shell="y"; break ;;
            [Nn]|"") ch_shell="n"; break ;;
        esac
    done

    if [ "$ch_shell" = "y" ]; then
        printf "\n%b\n" "${BLD}${CYE}Changing shell to Zsh (password may be required)...${CNC}"
        if chsh -s "$zsh_path"; then
            printf "%b\n" "${BLD}${CGR}Shell changed successfully to Zsh!${CNC}"
        else
            printf "%b\n" "${BLD}${CRE}Failed to change default shell.${CNC}"
        fi
        sleep 2
    fi
}

final_info() {
    clear
    logo "Done!"

    printf "%b\n" "${BLD}${CGR}Installation completed successfully!${CNC}"
    printf "%b\n" "========================================================================="
    printf "%b\n" "${BLD}${CMG}To apply the changes:${CNC}"
    printf "%b\n" "  1. Reload your shell: ${BLD}${CYE}source ~/.zshrc${CNC} (or start a new Zsh session)"
    printf "%b\n" "  2. Launch ${BLD}Alacritty${CNC} or ${BLD}Kitty${CNC} to see the premium interface!"
    printf "%b\n" "========================================================================="
    printf "%b\n\n" "Enjoy your new, decoupled terminal setup!"
}

# Main Execution Flow
initial_checks
welcome
install_dependencies
backup_configs
install_configs
set_default_shell
final_info
