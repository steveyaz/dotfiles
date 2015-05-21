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
find_port() { lsof -i tcp:$1; }

git-size() {
  # Shows you the largest objects in your repo's pack file.
  # Written for osx.
  #
  # @see https://stubbisms.wordpress.com/2009/07/10/git-script-to-show-largest-pack-objects-and-trim-your-waist-line/
  # @author Antony Stubbs

  # set the internal field spereator to line break, so that we can iterate easily over the verify-pack output
  IFS=$'\n';

  # Optional count for longer lists
  count=${1:-5}

  # list all objects including their size, sort by size, take top 10
  objects=`git verify-pack -v .git/objects/pack/pack-*.idx | grep -v chain | sort -k3nr | head -n $count`

  echo "All sizes are in kB's. The pack column is the size of the object, compressed, inside the pack file."

  output="size,pack,SHA,location"
  for y in $objects
  do
      # extract the size in bytes
      size=$((`echo $y | cut -f 5 -d ' '`/1024))
      # extract the compressed size in bytes
      compressedSize=$((`echo $y | cut -f 6 -d ' '`/1024))
      # extract the SHA
      sha=`echo $y | cut -f 1 -d ' '`
      # find the objects location in the repository tree
      other=`git rev-list --all --objects | grep $sha`
      #lineBreak=`echo -e "\n"`
      output="${output}\n${size},${compressedSize},${other}"
  done

  echo -e $output | column -t -s ', '

}
