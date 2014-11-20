alias reload='source ~/.bash_profile'
alias reload_prompt='source ~/.bashrc'

alias cls='printf "\033c"'
alias ll="ls -a1"
alias gits='git st'
alias gita='git add -A :/'
alias gitd='git df'
alias gitc='git ci -m'
alias gw='./gradlew'

greprails() { grep $1 -r --exclude-dir="coverage" --exclude-dir="tmp" $2; }
far() { find $1 -type f -name '*' -exec sed -i '' s/$2/$3/g {} + ; }
gitme() { git $1 --author=$(git config --get user.email); }

create_patch() {
  # Get the hash of the head
  head=$(git rev-parse --short HEAD)
  patched=$(git rev-parse --short patched)

  # Build the git bundle
  filename=patches/${patched}_to_${head}.gitbundle
  git bundle create $filename $patched..$head --all

  if [ -e $filename ]
  then
    # let the repo know that you are moving the pointer of the other repo
    git tag patched $head -f
    printf "\nExported to $filename \n"
  else
    printf "Failed to make the patch!"
    exit 1
  fi
}

bare_apply_patch() {
  if [ -z "$1" ]
  then
    read -p "Enter the name of the patch you want to apply: " filename
  else
    filename=$1
  fi

  if [ -e $filename ]
  then
    git fetch patches/$filename *:*
  else
    printf "Failed to find the patch!"
    exit 1
  fi
}

repo_apply_patch() {
  if [ -z "$1" ]
  then
    read -p "Enter the name of the patch you want to apply: " filename
  else
    filename=$1
  fi

  if [ -e $filename ]
  then
    git pull patches/$filename *:*
  else
    printf "Failed to find the patch!"
    exit 1
  fi
}
