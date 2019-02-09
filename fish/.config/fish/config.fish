# This attaches us to an open TMUX session if available, or a new one on shell start.
# test $TERM != "screen"; and exec tmux attach
# start_tmux
exec tmux attach

# alias vim to neovim because we're ~~modern~~
alias vim="nvim"
alias vi="nvim"

# export the color type for the folders on Windows so that they can
# be readable, otherwise the colors look terrible
LS_COLORS="ow=01;36;40"; and export LS_COLORS