#!/bin/bash

# Paths
BASH_PROFILE="$HOME/.bash_profile"
SHELL_COMMON="$HOME/.shell_common"

if [ ! -f "$BASH_PROFILE" ]; then
  echo "Error: $BASH_PROFILE not found!"
  exit 1
fi

# Extract PATH and brew shellenv lines
grep -E '^(export PATH|PATH=|eval .*/brew shellenv)' "$BASH_PROFILE" > "$SHELL_COMMON"

echo "Extracted PATH-related lines from $BASH_PROFILE to $SHELL_COMMON"
