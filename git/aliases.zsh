alias g="git add -u && git commit -m "

alias gpp='git pull && git push'
alias gra='git rebase --abort'
alias grc='git rebase --continue'

# The rest of my fun git aliases
alias gl='git pull --prune'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp='git push origin HEAD'
alias gd='git diff'
alias gc='git commit'
alias gca='git commit -a'
alias gbc='git branch --list "bkies/*" "master" "abstech/*" "atech/*"'
alias gbn='git checkout -b '
alias gco='git checkout'
alias gb='git branch'
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias grm="git status | grep deleted | awk '{\$1=\$2=\"\"; print \$0}' | \
           perl -pe 's/^[ \t]*//' | sed 's/ /\\\\ /g' | xargs git rm"

alias gcaa="git commit -a --amend"
alias gpr="git pull --rebase origin master"
alias gitarchive="git branch -m "

alias pull-request='git push origin -u && git pull-request'
alias git-files="git diff-tree --no-commit-id --name-only -r"
