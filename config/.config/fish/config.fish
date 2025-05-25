
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /Users/aneesh/micromamba/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<


# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
set -gx MAMBA_EXE "/Users/aneesh/.micromamba/bin/micromamba"
set -gx MAMBA_ROOT_PREFIX "/Users/aneesh/micromamba"
eval "/Users/aneesh/.micromamba/bin/micromamba" shell hook --shell fish --prefix "/Users/aneesh/micromamba" | source
# <<< mamba initialize <<<
