#!/usr/bin/env bash
set -euo pipefail

BREWFILE="./brew/Brewfile"
LINUX_TXT="./linux_packages.txt"

# Check and source package map
if [[ -f ./package_map.sh ]]; then
  source ./package_map.sh
else
  echo "❌ package_map.sh not found"
  exit 1
fi

UNAME_S=$(uname -s)

if [[ "$UNAME_S" == "Linux" ]]; then
  echo "Select your Linux distro:"
  echo "1) Arch (yay)"
  echo "2) Debian/Ubuntu (apt)"
  echo "3) Fedora (dnf)"
  read -rp "Enter number [1-3]: " DISTRO_CHOICE
fi

# Arrays to hold parsed packages
BREW_PACKAGES=()
CASK_PACKAGES=()
VSCODE_EXTENSIONS=()
TAPS=()
LINUX_TXT_PACKAGES=()

parse_brewfile() {
  local file="$1"
  while IFS= read -r line; do
    line="${line#"${line%%[![:space:]]*}"}" # trim leading spaces
    line="${line%"${line##*[![:space:]]}"}" # trim trailing spaces
    [[ -z "$line" || "$line" =~ ^# ]] && continue

    if [[ $line =~ ^tap\ \"([^\"]+)\" ]]; then
      TAPS+=("${BASH_REMATCH[1]}")
    elif [[ $line =~ ^brew\ \"([^\"]+)\" ]]; then
      BREW_PACKAGES+=("${BASH_REMATCH[1]}")
    elif [[ $line =~ ^cask\ \"([^\"]+)\" ]]; then
      CASK_PACKAGES+=("${BASH_REMATCH[1]}")
    elif [[ $line =~ ^vscode\ \"([^\"]+)\" ]]; then
      VSCODE_EXTENSIONS+=("${BASH_REMATCH[1]}")
    fi
  done <"$file"
}

# Parse Brewfile if exists
if [[ -f "$BREWFILE" ]]; then
  echo "📄 Parsing packages from $BREWFILE..."
  parse_brewfile "$BREWFILE"
fi

# Parse linux_packages.txt if exists (simple list of package names)
if [[ -f "$LINUX_TXT" ]]; then
  echo "📄 Parsing packages from $LINUX_TXT..."
  while IFS= read -r pkg; do
    pkg="${pkg#"${pkg%%[![:space:]]*}"}"
    pkg="${pkg%"${pkg##*[![:space:]]}"}"
    [[ -z "$pkg" || "$pkg" =~ ^# ]] && continue
    LINUX_TXT_PACKAGES+=("$pkg")
  done <"$LINUX_TXT"
fi

install_brew() {
  if ! command -v brew &>/dev/null; then
    echo "📦 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  for tap in "${TAPS[@]}"; do
    brew tap "$tap" || true
  done

  # Install Brewfile brew and cask packages
  [[ ${#BREW_PACKAGES[@]} -gt 0 ]] && brew install "${BREW_PACKAGES[@]}"
  [[ ${#CASK_PACKAGES[@]} -gt 0 ]] && brew install --cask "${CASK_PACKAGES[@]}"

  # Install packages from linux_packages.txt via brew on macOS
  if [[ ${#LINUX_TXT_PACKAGES[@]} -gt 0 ]]; then
    echo "Installing packages from linux_packages.txt via brew on macOS:"
    printf ' - %s\n' "${LINUX_TXT_PACKAGES[@]}"
    brew install "${LINUX_TXT_PACKAGES[@]}" || echo "⚠️ Some linux_packages.txt packages failed to install on macOS"
  fi
}

install_linux() {
  # Map Brewfile packages to Linux package names
  MAPPED_LINUX_PKGS=()
  for pkg in "${BREW_PACKAGES[@]}"; do
    MAPPED_LINUX_PKGS+=("$(get_linux_package "$pkg")")
  done

  # Combine mapped brewfile packages and linux_packages.txt packages
  ALL_LINUX_PKGS=("${MAPPED_LINUX_PKGS[@]}" "${LINUX_TXT_PACKAGES[@]}")

  echo "📦 Installing the following Linux packages:"
  printf ' - %s\n' "${ALL_LINUX_PKGS[@]}"

  case "$DISTRO_CHOICE" in
  1)
    if ! command -v yay >/dev/null 2>&1; then
      echo "❌ 'yay' not found. Please install yay manually and re-run."
      exit 1
    fi
    for pkg in "${ALL_LINUX_PKGS[@]}"; do
      yay -S --noconfirm "$pkg" || echo "Failed: $pkg"
    done
    ;;
  2)
    sudo apt update
    sudo apt install -y "${ALL_LINUX_PKGS[@]}"
    ;;
  3)
    sudo dnf install -y "${ALL_LINUX_PKGS[@]}"
    ;;
  *)
    echo "❌ Unsupported distro selection."
    exit 1
    ;;
  esac
}

install_vscode_extensions() {
  if ! command -v code &>/dev/null; then
    echo "🛑 VSCode CLI (code) not found. Skipping extension installation."
    return
  fi

  echo "💻 Installing VSCode extensions..."
  for ext in "${VSCODE_EXTENSIONS[@]}"; do
    code --install-extension "$ext" || echo "❌ Failed to install $ext"
  done
}

# Run based on OS
if [[ "$UNAME_S" == "Darwin" ]]; then
  install_brew
  install_vscode_extensions
elif [[ "$UNAME_S" == "Linux" ]]; then
  install_linux
  install_vscode_extensions
else
  echo "❌ Unsupported OS: $UNAME_S"
  exit 1
fi

echo "✅ Installation complete."
