# This attaches us to an open TMUX session if available, or a new one on shell start.
# test $TERM != "screen"; and exec tmux attach
# start_tmux
# exec tmux attach

# alias vim to neovim because we're ~~modern~~
alias vim="nvim"
alias vi="nvim"
setenv EDITOR nvim

# Environment
export BAT_CONFIG_PATH="~/.config/bat/bat.config"

# ALIASES
alias upgrade="sudo apt update; and sudo apt upgrade -y"
alias cleanup="sudo apt autoremove -y; and sudo apt autoclean"
alias k=kubectl
alias tf=terraform
thefuck --alias | source

## GIT
# Remove all traces of git from a folder
alias degit="find . -name '.git' -exec rm -rf {} \;"
# add and remove new/deleted files from git index automatically
alias gitar="git ls-files -d -m -o -z --exclude-standard | xargs -0 git update-index --add --remove"
# Git common
alias get="git clone"
alias gd="git diff"
alias gs="git status -bs"

# Get current external IP
alias ip="curl icanhazip.com"

# copy the working directory path
alias cpwd='pwd|tr -d "\n"|pbcopy'

# Source the fish config.
source /usr/local/anaconda3/etc/fish/conf.d/conda.fish

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval (eval /usr/local/anaconda3/bin/conda "shell.fish" "hook" $argv)
# <<< conda initialize <<<
