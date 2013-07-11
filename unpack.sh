#!/bin/sh
move() {
	file=$1
	echo "Moving file: $file to $HOME"
	cp $file $HOME/$file
}

files=(.bash_profile .bashrc .bash_aliases .gemrc .gitconfig .irbrc .irbrc_rails)

for file in ${files[@]}
do
	move $file
done

echo "Sourcing the bash_profile"
source $HOME/.bash_profile
