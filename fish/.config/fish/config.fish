# This attaches us to an open TMUX session if available, or a new one on shell start.
# test $TERM != "screen"; and exec tmux attach
# start_tmux
# exec tmux attach

# Environment
export BAT_CONFIG_PATH="~/.config/bat/config"

# Start in Vi mode
fish_vi_key_bindings

# ALIASES
alias dockerclean="docker system prune -a -f; docker volume prune -f; docker image prune -a -f"
alias k=kubectl
alias tf=terraform
alias g=gcloud
alias ip="curl icanhazip.com" # Get current external IP
# alias vim to neovim because we're ~~modern~~
alias vim="nvim"
alias vi="nvim"
set -x EDITOR nvim

# Use RipGrep in FZF
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'

# Set the color theme.
theme.sh solarized-light
