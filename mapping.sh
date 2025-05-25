#!/usr/bin/env bash
# package_map.sh - Maps package names between Homebrew and Linux (when names differ)

# Linux → Brew mappings (only if names differ)
declare -A linux_to_brew=(
  ["python3"]="python"
  ["mysql-client"]="mysql"
)

# Brew → Linux mappings (only if names differ)
declare -A brew_to_linux=(
  ["python"]="python3"
  ["mysql"]="mysql-client"
)

# Get mapped Linux package name from brew package
get_linux_package() {
  local brew_name="$1"
  if [[ -n "${brew_to_linux[$brew_name]+set}" ]]; then
    echo "${brew_to_linux[$brew_name]}"
  else
    echo "$brew_name"  # fallback: assume same
  fi
}

# Get mapped brew package name from Linux package
get_brew_package() {
  local linux_name="$1"
  if [[ -n "${linux_to_brew[$linux_name]+set}" ]]; then
    echo "${linux_to_brew[$linux_name]}"
  else
    echo "$linux_name"  # fallback
  fi
}
