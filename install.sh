# !/bin/sh

# LAPTOP SETTINGS
# turn mouse sensitivity all the way up
# enable tap to click
# enable dragging, without drag lock: System Prefences => Accessibility => Trackpad Options

# KEYBOARD SETTINGS
# remap caps lock to control

# INSTALLS
# iTerm (Terminal)
# Chrome (Browser)
# Rectangle (Window Manager)

# INSTALL HOMEBREW
# https://github.com/mikelxc/Workarounds-for-ARM-mac

# EXIT IF ANY SINGLE COMMAND FAILS
set -e

# INSTALL HOMEBREW PACKAGES
brew bundle

# SYM LINK DOT FILES
./symlink_dotfiles

# create directory for vim swap files
mkdir -p ~/.vim/swp

# install vim plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install vim plugins
vim +'PlugInstall --sync' +qa

# INSTALL RUBY
asdf plugin add ruby
asdf install ruby latest
# run: asdf global ruby VERSION_INSTALLED

# "zsh compinit: insecure directories and files, run compaudit for list." Solution:
#
# https://github.com/zsh-users/zsh-completions/issues/433#issuecomment-619321054
compaudit | xargs chmod g-w

# GENERATE SSH KEY FOR GITHUB
ssh-keygen -t ed25519 -C "nick@pachulski.me"
eval "$(ssh-agent -s)"
touch ~/.ssh/config
echo "Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519" >> ~/.ssh/config
ssh-add -K ~/.ssh/id_ed25519
pbcopy < ~/.ssh/id_ed25519.pub
# go to github and paste in the ssh key from the clipboard
