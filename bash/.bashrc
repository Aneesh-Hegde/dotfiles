eval "$(starship init bash)"

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

#Yazi setup
export EDITOR="nvim"
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

#color output of ls
alias ls='ls --color=auto'

#tmux alias
alias tmux-ls='~/.config/tmux/tmux-fzf'
alias tmux-code='~/.config/tmux/tmux-fzf code'
alias tmux-flex='~/.config/tmux/tmux-fzf flex'

#vim motion on terminal
set -o vi
