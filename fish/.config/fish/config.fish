# This attaches us to an open TMUX session if available, or a new one on shell start.
# test $TERM != "screen"; and exec tmux attach
# start_tmux
# exec tmux attach

# alias vim to neovim because we're ~~modern~~
alias vim="nvim"
alias vi="nvim"
setenv EDITOR nvim
