#!/usr/local/bin/fish
# file: fish.sh

# Install OMF
if test -d ~/.config/omf
  echo "OMF already installed."
else
  echo "Installing oh-my-fish!"
  curl -L https://get.oh-my.fish | fish
end

# Install fish plugins
set -l plugins fish-kubectl-completions fish-nvm brew-completions bass eclm fish-spec
for plug in $plugins
  omf install $plug
end
echo "Fish plugins installed!"

# Reload the shell for changes to take effect.
omf reload
