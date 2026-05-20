# 💻 Decoupled Terminal Configuration (Zsh, Alacritty, Kitty)

This is a premium, fully decoupled terminal setup extracted from **gh0stzk/dotfiles**. It packages the extremely fast, GPU-accelerated terminal emulators (**Alacritty** and **Kitty**) along with a heavily optimized **Zsh** shell environment, interactive **fzf-tab** completions, custom aliases, syntax highlighting, autosuggestions, and colorful startup banners.

By isolating these files into this self-contained directory, you can easily deploy, customize, and maintain your terminal environment on any system without installing the full bspwm desktop configuration.

---

## 📂 Directory Structure

Here is a visual map of the decoupled terminal configuration files:

```
terminal-config/
├── bin/
│   └── colorscript           # Terminal startup banner generator
├── config/
│   ├── alacritty/
│   │   ├── alacritty.toml    # Main Alacritty settings
│   │   ├── fonts.toml        # Font family and size settings
│   │   └── rice-colors.toml  # Tokyo Night color palette
│   └── kitty/
│       ├── kitty.conf        # Main Kitty configuration
│       └── themes/           # Folder containing 18 custom color themes
├── home/
│   └── .zshrc                # Optimized Zsh configuration and interactive shell setup
└── setup.sh                  # Standalone interactive installation script
```

---

## ⚙️ System Dependencies

To unlock the full potential of this environment (including icons, code syntax highlighting, and interactive previews), make sure the following packages are installed on your system:

### **Arch Linux (Recommended)**
The interactive installer (`setup.sh`) will offer to install these automatically via `pacman` and your AUR helper (`paru` or `yay`):
* **Terminal Emulators:** `alacritty`, `kitty`
* **Shell & Core Utilities:** `zsh`, `eza` (modern `ls`), `bat` (syntax highlighted `cat`), `fzf` (fuzzy finder)
* **Zsh Plugins:** `zsh-autosuggestions`, `zsh-syntax-highlighting`, `zsh-history-substring-search`
* **AUR Dependencies:** `fzf-tab-git` (provides live completions previews in Zsh)
* **Fonts:** `ttf-jetbrains-mono-nerd`

### **Other Distributions (Ubuntu, Fedora, macOS, etc.)**
Install the corresponding package equivalents using your package manager (e.g., `apt`, `dnf`, or `brew`), and make sure a **Nerd Font** (like JetBrainsMono Nerd Font) is installed as your system terminal font.

---

## 🚀 How to Install and Use

Installing the configuration is extremely simple, interactive, and completely safe:

### **1. Execute the Setup Script**
Navigate to this directory and run the `setup.sh` script:
```bash
chmod +x setup.sh
./setup.sh
```

### **2. What the Setup Script Does:**
1. **Safety Checks:** Ensures the script is not run as root to avoid corrupting system paths.
2. **Package Installation:** Prompts you to install or update the dependencies (Arch Linux only).
3. **Automatic Smart Backups:** Checks your current directories. If existing configurations for `alacritty`, `kitty`, `zsh`, `.zshrc`, or `colorscript` are found, they are automatically renamed and moved to a safe backup directory:
   `~/.terminal_config_backup/YYYYMMDD-HHMMSS/`
4. **Clean File Copying:** Automatically copies and configures all configuration files into your local user folders:
   - configs to `~/.config/`
   - `.zshrc` to `~/`
   - `colorscript` to `~/.local/bin/` (and makes it executable)
5. **Default Shell Change:** Prompts you to change your default shell to Zsh using `chsh`.

### **3. Activate Your New Environment**
After the installation completes, reload your shell to activate the configurations immediately:
```bash
source ~/.zshrc
```
Launch **Alacritty** or **Kitty** to see your premium, customized terminal in action!

---

## 🎨 How to Customize Your Terminal

This configuration has been modularized so that you can tweak individual components easily without breaking the overall design.

### 1. Alacritty Customization

All Alacritty configurations are located under `~/.config/alacritty/`:

* **Changing Fonts and Size:**
  Edit `~/.config/alacritty/fonts.toml` to change the font family or font size:
  ```toml
  [font]
  size = 11  # Change font size here
  
  [font.normal]
  family = "JetBrainsMono Nerd Font"  # Or your preferred Nerd Font
  ```

* **Customizing Colors:**
  Edit `~/.config/alacritty/rice-colors.toml` to modify the Tokyo Night background, foreground, or ANSI accent colors.

* **Adjusting Transparency and Padding:**
  Edit `~/.config/alacritty/alacritty.toml` to change window padding or adjust opacity (if your composite manager is active):
  ```toml
  [window]
  opacity = 0.95  # 1.0 is fully opaque, 0.0 is fully transparent
  padding = { x = 12, y = 12 }
  ```

---

### 2. Kitty Customization

All Kitty configurations are located under `~/.config/kitty/`:

* **Modifying Basic Properties:**
  Edit `~/.config/kitty/kitty.conf` to change properties like `font_size`, `window_padding_width`, `scrollback_lines`, or cursor behavior.

* **Switching Color Themes:**
  Kitty comes bundled with **18 beautiful pre-configured themes** in `~/.config/kitty/themes/`. 
  To apply a new theme, simply import it at the end of your `~/.config/kitty/kitty.conf` file:
  ```conf
  # Add this line at the bottom of kitty.conf to use the 'z0mbi3' theme
  include themes/z0mbi3.conf
  ```
  *(Available themes include: `aline`, `cristina`, `cynthia`, `daniela`, `emilia`, `h4ck3r`, `marisol`, `melissa`, `pamela`, `yael`, `z0mbi3`, etc.)*

---

### 3. Zsh Shell Customization

Your shell prompt, aliases, and plugins are defined in `~/.zshrc`:

* **Adding Custom Aliases:**
  Open `~/.zshrc` and scroll to the bottom section marked `# ALIASES`. You can add your custom shortcuts there:
  ```bash
  # Custom Aliases
  alias gs="git status"
  alias gp="git push"
  alias gc="git commit -m"
  ```

* **Managing Interactive Completion Previews (`fzf-tab`):**
  This configuration uses `fzf-tab` to display interactive tab completions. The preview styles are configured under the `# zstyle` settings in your `.zshrc`.
  - For example, when typing `cd <TAB>` or `eza <TAB>`, Zsh will use `eza` to draw an interactive directory tree.
  - When typing `bat <TAB>` or `cat <TAB>`, Zsh will preview the files inside a scrollable `bat` container.

* **Managing the Startup Banner:**
  By default, `colorscript` is executed on startup to display a randomized ASCII artwork in your terminal.
  - **To change the banner style:** Edit the startup flag at the bottom of `~/.zshrc`. E.g., `colorscript -e crunch` to always use the crunch font banner.
  - **To disable the banner:** Comment out or delete the startup command at the bottom of `~/.zshrc`:
    ```bash
    # Comment this out to disable the welcome colorscript
    # $HOME/.local/bin/colorscript -r
    ```

---

## 🔍 Troubleshooting

### **1. Icons are not rendering correctly (showing square boxes or question marks)**
* **Cause:** The current terminal font does not support Nerd Font glyphs/icons.
* **Solution:** Install a Nerd Font (such as **JetBrainsMono Nerd Font**) on your system. Make sure the font family name matches exactly in your `~/.config/alacritty/fonts.toml` or `~/.config/kitty/kitty.conf`.

### **2. Error: `fzf-tab.zsh` not found**
* **Cause:** The `fzf-tab-git` AUR package is not installed, or its script path is different on your system.
* **Solution:** Make sure `fzf-tab-git` is installed. If you installed it manually or are on a non-Arch system, find the path to the `fzf-tab.zsh` script and update line 116 in `~/.zshrc`:
  ```bash
  source /path/to/your/fzf-tab.zsh
  ```

### **3. Startup banner `colorscript: command not found`**
* **Cause:** `~/.local/bin` is not included in your system's global `$PATH` environment variable.
* **Solution:** The Zsh setup includes an automatic check for `~/.local/bin` and adds it to your path dynamically on shell startup. If it is still missing, add the following line to your `~/.zprofile` or at the top of your `~/.zshrc`:
  ```bash
  export PATH="$HOME/.local/bin:$PATH"
  ```
