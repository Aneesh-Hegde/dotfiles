# 🧰 Dotfiles Installer

Cross-platform (macOS + Linux) dotfiles setup using **GNU Stow**, **Homebrew-style package lists**, and a smart OS-aware installer.

---

## ⚙️ Prerequisites

Before you begin, make sure you have the following tools installed:

### macOS

- **Xcode Command Line Tools** (required for compilers and build tools):  
  Run in Terminal:  
  ```bash
  xcode-select --install
  ```

Follow the installation prompts.

* **Git** (for cloning the repository):
  Install via Homebrew:

  ```bash
  brew install git
  ```

* **GNU Stow** (for managing symlinks):
  Install via Homebrew:

  ```bash
  brew install stow
  ```

* **Bash** version 4 or higher (default on macOS Catalina and later):
  Check version with:

  ```bash
  bash --version
  ```

* **VSCode CLI (optional)** to install extensions:
  Open VSCode, press `Cmd+Shift+P`, and run:
  `Shell Command: Install 'code' command in PATH`

### Linux

* **Git** (for cloning the repository):
  Install with your distro’s package manager, for example:

  ```bash
  sudo apt install git      # Debian/Ubuntu
  sudo pacman -S git        # Arch
  sudo dnf install git      # Fedora
  ```

* **GNU Stow** (for managing symlinks):
  Install with your distro’s package manager, for example:

  ```bash
  sudo apt install stow     # Debian/Ubuntu
  sudo pacman -S stow       # Arch
  sudo dnf install stow     # Fedora
  ```

* **Bash** version 4 or higher:
  Check version with:

  ```bash
  bash --version
  ```

  Install or upgrade if necessary.

* **VSCode CLI (optional)** to install extensions:
  Install VSCode manually, then ensure `code` CLI is available on your PATH.

---

## 📦 Install Instructions

```bash
# 1. Clone this repo
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# 2. Run the installer
make
```

This will:

* Symlink your dotfiles using GNU Stow (excluding fonts/)
* Detect your OS and:

  * Install packages from `brew/Brewfile`
  * Prompt for Linux distro and install mapped packages (`yay`, `apt`, `dnf`)
  * Optionally install VSCode extensions

### 🔄 Watch both `.bash_profile` and `.zprofile` for PATH changes

To automatically sync environment variables (like PATH) from both Bash and Zsh profiles into a shared `.shell_common`, you can use:

* Macos
```bash
brew install fswatch
```
* Ubuntu/Debian	
```bash
sudo apt install fswatch
```
* Fedora	
```bash
sudo dnf install fswatch
```
* Arch Linux	
```bash
sudo pacman -S fswatch
```
In order to track the change in file the below command need to run in background(recommended to run in a tmux session in background)
```bash
fswatch -o ~/.bash_profile ~/.zprofile | while read num; do
  ~/dotfiles/scripts/extract_path_to_shell_common.sh
done
```

---

## 🐧 Linux Distro Support

When running on Linux, you'll be prompted to select:

```
1) Arch (yay)
2) Debian/Ubuntu (apt)
3) Fedora (dnf)
```

Your packages from the Brewfile will be automatically mapped to Linux equivalents (based on `mapping.sh`).

---

## 📁 Directory Structure

```
.
├── brew/              # Homebrew-like package list
│   └── Brewfile
├── linux/             # Linux-specific logic
│   └── install.sh
├── mapping.sh         # Brew ↔ Linux package mappings
├── install.sh         # Cross-platform install entrypoint
├── linux-dump.sh      # Generate Linux Brewfile from installed packages
├── Makefile           # CLI entry: install, uninstall, clean
├── fonts/             # Fonts (ignored by default)
└── README.md
```

---

## 🔀 Customizing Your Setup

### Add packages:

Edit the `brew/Brewfile`:

```bash
tap "homebrew/cask"
brew "wget"
cask "google-chrome"
vscode "esbenp.prettier-vscode"
```
or run

```bash
  brew bundle dump --describe
```


### Add mappings for Linux:

If a Linux equivalent has a different name, add it to `mapping.sh`:

```bash
# mapping.sh
["python"]="python3"
["mysql"]="mysql-client"
```

---

## 🧪 Dump Linux Packages to Brewfile

Use this to generate a `brew/Brewfile` from your current Linux system:

```bash
./linux-dump.sh
```

Supports:

* Arch (`pacman`)
* Debian/Ubuntu (`dpkg`)
* Fedora (`dnf`)

---

## 🧹 Additional Commands

### Uninstall symlinks (dotfiles only):

```bash
make uninstall
```

### Clean junk files:

```bash
make clean
```

Removes `.DS_Store` and `*~` backup files.

---
`Note: Install spicetify`
## ✅ Example Workflow

```bash
# Prerequisites (macOS example)
xcode-select --install
brew install git stow

# Prerequisites (Linux example - Ubuntu)
sudo apt install git stow

# Setup
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make
```

---



