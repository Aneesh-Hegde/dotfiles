
Absolutely! Here’s the **complete README.md** with your requested **line-by-line Prerequisites** for macOS and Linux, plus all sections included:

# 🧰 Dotfiles Installer

Cross-platform (macOS + Linux) dotfiles setup using **GNU Stow**, **Homebrew-style package lists**, and a smart OS-aware installer.

---

## ⚙️ Prerequisites

Before you begin, make sure you have the following tools installed:

### macOS

- **Xcode Command Line Tools** (required for compilers and build tools):  
  Run in Terminal:  
  ```bash
  ```
  ```bash
  xcode-select --install
````

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
./linux-dump.sh > brew/Brewfile
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

## 📜 License

MIT – use freely, share widely, customize deeply.

```

If you want me to help with adding font setup, shell config tips, or screenshots, just ask!
```

