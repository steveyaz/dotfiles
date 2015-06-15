# Install brew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Make sure it is up to date
brew update

# Install autocomplete
brew install bash-completion

# Install tree
brew install tree

# Install Python
brew install python

# Install GNU Tools
brew install gnu-tar
brew install gnu-sed

# Install vim
brew install vim
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone git@github.com:Lokaltog/powerline-fonts.git
vim +PluginInstall +qall

# Install rbenv
brew install rbenv
brew install ruby-build

# Install Ruby
rbenv install 2.0.0-p247
rbenv global 2.0.0-p247

# Install some gems
rbenv rehash
gem install rails
rbenv rehash

# Symlink sublime for editor
ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl

# Make the commandhistory repo
mkdir -p ~/.history_repo

# Unpack Dotfiles
./setup/dotfiles.sh

