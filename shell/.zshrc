export ZSH="$HOME/.zsh"

# if [ -f ~/.bash_profile ]; then
#   source ~/.bash_profile
# elif [ -f ~/.bashrc ]; then
#   source ~/.bashrc
# fi

eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship.toml

export PATH=$PATH:/Users/aneesh/go/bin

# Add Clang to PATH (Replace `/path/to/clang/bin` with the actual path to Clang binaries)
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

# Set Clang as the default compiler
export CC=clang
export CXX=clang++

# Compiler flags
export CFLAGS="-O2 -Wall"
export CXXFLAGS="-O2 -Wall"

# Linker flags (Replace `/path/to/libraries` with the correct path to libraries, e.g., /opt/homebrew/lib)
export LDFLAGS="-L/opt/homebrew/lib"

# Include file directories (Replace `/path/to/includes` with the correct include directory, e.g., /opt/homebrew/include)
export CPATH="/opt/homebrew/include:$CPATH"

# Library paths (Replace `/path/to/lib` with the correct path, e.g., /opt/homebrew/lib)
export LIBRARY_PATH="/opt/homebrew/lib:$LIBRARY_PATH"
export LD_LIBRARY_PATH="/opt/homebrew/lib:$LD_LIBRARY_PATH"

# Add Homebrew LLVM/Clang to PATH (This should already be covered above, but this ensures it's set)
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

# Yazi setup
export EDITOR="nvim"
function y() {
  local tmp=$(mktemp -t "yazi-cwd.XXXXXX")
  yazi "$@" --cwd-file="$tmp"
  if [[ -s $tmp ]]; then
    local cwd=$(cat "$tmp")
    if [[ -n $cwd && $cwd != $PWD ]]; then
      builtin cd -- "$cwd"
    fi
  fi
  rm -f -- "$tmp"
}

# Vim mode on terminal
bindkey -v
bindkey jj vi-cmd-mode

# Source shared aliases
[ -f "$HOME/.shell_aliases" ] && source "$HOME/.shell_aliases"
