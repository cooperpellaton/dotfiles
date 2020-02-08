# This attaches us to an open TMUX session if available, or a new one on shell start.
# test $TERM != "screen"; and exec tmux attach
# start_tmux
# exec tmux attach

# alias vim to neovim because we're ~~modern~~
alias vim="nvim"
alias vi="nvim"
setenv EDITOR nvim

# Environment
export BAT_CONFIG_PATH="~/.config/bat/config"

# Start in Vi mode
fish_vi_key_bindings

# ALIASES
alias uc="brew upgrade; brew cleanup"
alias dockerclean="docker system prune -a -f; docker volume prune -f; docker image prune -a -f"
alias k=kubectl
alias tf=terraform
alias g=gcloud
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

# Source the Conda fish config.
source /usr/local/anaconda3/etc/fish/conf.d/conda.fish

# The next line enables shell command completion for gcloud.
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc
bass source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc

function fish_greeting
  fortune -a
end

starship init fish | source
