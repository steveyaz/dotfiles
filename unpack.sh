#!/bin/sh
link() {
	file=$1
  current=`pwd`
  echo "Linking file($file) from $current to $HOME"
	ln -s $current/$file $HOME/$file
}

files=(.bash_profile .bashrc .bash_aliases .bash_palantir .gemrc .gitconfig .irbrc .irbrc_rails .vimrc .gitignore)

for file in ${files[@]}
do
	link $file
done

echo "Sourcing the bash_profile"
source $HOME/.bash_profile
