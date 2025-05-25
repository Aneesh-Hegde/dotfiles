export PATH=${PATH}:/usr/local/mysql-8.0.28-macos11-arm64/bin
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/opt/homebrew/opt/mysql@5.7/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql@5.7/bin:$PATH"

# Setting PATH for Python 3.10
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:${PATH}"
export PATH

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/aneesh/micromamba/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/aneesh/micromamba/etc/profile.d/conda.sh" ]; then
        . "/Users/aneesh/micromamba/etc/profile.d/conda.sh"
    else
        export PATH="/Users/aneesh/micromamba/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# Setting PATH for Python 3.10
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:${PATH}"
export PATH

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE="/Users/aneesh/.micromamba/bin/micromamba";
export MAMBA_ROOT_PREFIX="/Users/aneesh/micromamba";
__mamba_setup="$('/Users/aneesh/.micromamba/bin/micromamba' shell hook --shell bash --prefix '/Users/aneesh/micromamba' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    if [ -f "/Users/aneesh/micromamba/etc/profile.d/micromamba.sh" ]; then
        . "/Users/aneesh/micromamba/etc/profile.d/micromamba.sh"
    else
        export  PATH="/Users/aneesh/micromamba/bin:$PATH"  # extra space after export prevents interference from conda init
    fi
fi
unset __mamba_setup
# <<< mamba initialize <<<
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
[ -f ~/.shell_common ] && source ~/.shell_common
