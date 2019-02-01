#!/bin/sh
link() {
	file=$1
  current=`pwd`
  echo "Linking file($file) from $current to $HOME"
	ln -s $current/$file $HOME/$file
}

# Symlink dotfiles
files=(.bash_profile .bashrc .bash_aliases .bash_palantir .gitconfig .vimrc .gitignore .vim)

for file in ${files[@]}
do
	link $file
done

# Ensure the .vim folder exists
#mkdir $HOME/.vim

# Symlink vim folder
#current=`pwd`
#for vim_folder in `ls $current/.vim`
#do
#  link $vim_folder
#done

# Make the commandhistory repo
mkdir -p ~/.history_repo

echo "Sourcing the bash_profile"
source $HOME/.bash_profile
