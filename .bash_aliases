alias reload='source ~/.bash_profile'
alias reload_prompt='source ~/.bashrc'

alias cls='printf "\033c"'
alias ll="ls -a1"
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"

greprails() { grep $1 -r --exclude-dir="coverage" --exclude-dir="tmp" $2; }
far() { find $1 -type f -print0 | xargs -0 sed -i "s/$2/$3/g"; }
