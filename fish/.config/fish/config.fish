# This attaches us to an open TMUX session if available, or a new one on shell start.
# test $TERM != "screen"; and exec tmux attach
# start_tmux
# exec tmux attach

# bobthefish settings
set theme_color_scheme dracula

# alias vim to neovim because we're ~~modern~~
alias vim="nvim"
alias vi="nvim"
setenv EDITOR nvim

# system aliases
alias upgrade="sudo apt update; and sudo apt upgrade -y"
alias cleanup="sudo apt autoremove -y; and sudo apt autoclean"
thefuck --alias | source
