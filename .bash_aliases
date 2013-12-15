alias reload='source ~/.bash_profile'
alias reload_prompt='source ~/.bashrc'

alias cls='printf "\033c"'
alias ll="ls -a1"
alias gits='git st'
alias gita='git add -A :/'

alias pelasticsearch='elasticsearch -f -D es.config=/usr/local/opt/elasticsearch/config/elasticsearch.yml'
alias pworkspace='cd ~/palantir/workspace/'
alias pproject='cd ~/palantir/workspace/kessel-run/kessel-run-app/plugins/kessel-run-web/src/main/resources'
alias pcurrent='cd ~/palantir/versions/3.11.1.2'
alias pgeclipse='GRADLE_OPTS=-Xmx2g ./gradlew eclipse --info'
alias pclearstate='curl -XDELETE http://localhost:9200/storage-user-state'

greprails() { grep $1 -r --exclude-dir="coverage" --exclude-dir="tmp" $2; }
far() { find $1 -type f -name '*' -exec sed -i '' s/$2/$3/g {} + ; }
