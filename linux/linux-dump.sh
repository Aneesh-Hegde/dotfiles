#!/usr/bin/env bash
set -euo pipefail

output_file="linux_packages.txt"

echo "# Auto-generated Brewfile-like packages for Linux" > "$output_file"

if command -v pacman &>/dev/null; then
  # Arch Linux
  for pkg in $(pacman -Qq); do
    echo "brew \"$pkg\"" >> "$output_file"
  done
elif command -v apt &>/dev/null; then
  # Debian/Ubuntu
  dpkg-query -W -f='${binary:Package}\n' | while read -r pkg; do
    echo "brew \"$pkg\"" >> "$output_file"
  done
elif command -v dnf &>/dev/null; then
  # Fedora
  dnf list installed | tail -n +2 | awk '{print $1}' | while read -r pkg; do
    echo "brew \"$pkg\"" >> "$output_file"
  done
else
  echo "Unsupported Linux distro for dumping packages" >&2
  exit 1
fi

