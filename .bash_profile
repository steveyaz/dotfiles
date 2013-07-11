if [ -x /usr/libexec/path_helper ]; then
	eval `/usr/libexec/path_helper -s`
fi

# include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# include .bash_aliases if it exists
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi
