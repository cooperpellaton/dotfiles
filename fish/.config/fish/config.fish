# This attaches us to an open TMUX session if available, or a new one on shell start.
# test $TERM != "screen"; and exec tmux attach
# start_tmux
# exec tmux attach

# Environment
set BAT_CONFIG_PATH ~/.config/bat/config

# note: this erases the default fish_mode_prompt, which adds a vi mode
# indicator to the left of your prompt
function fish_mode_prompt; end

# Start in Vi mode
fish_vi_key_bindings

# ALIASES
# abbr -a -g dockerclean docker system prune -a -f; docker volume prune -f; docker image prune -a -f
abbr -a -g k kubectl
abbr -a -g tf terraform
abbr -a -g g gcloud
abbr -a -g ip curl icanhazip.com # Get current external IP
alias rm="rm -i"

zoxide init fish | source
# kubectl completion fish | source
