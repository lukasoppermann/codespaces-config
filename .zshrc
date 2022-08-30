function push() {
  current_branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
  if [[ ($1 == "-f" && ($2 == "tag" || $2 == "tags")) ]]; then
    git push -f --tags origin $current_branch
  elif [[ ($1 == "tag" || $1 == "tags") && $2 == "-f" ]]; then
    git push -f --tags origin $current_branch
  elif [[ $1 == "tags" || $1 == "tag"  || $1 == "--tags" ]]; then
    git push && git push --tags origin $current_branch
  elif [[ ! -z "$1" ]]; then
    git push $1
  else
    git push origin $current_branch
  fi

}
function cm() {
  msg=${*:1}
  if [[ -z "$msg" ]]; then
    echo -n "Enter a commit message:"
    read message
    msg=$message
  fi
  git commit -m "$msg"

}
function :() {
if [[ ! -z "$1" ]]; then
  git push origin :$1
  if [[ ($2 == "-b") ]]; then
    git branch -D $1
  fi
fi
}
function diff() {
if [[ ! -z "$1" ]]; then
  git diff --color "$@" | diff-so-fancy
else
  git diff --color | diff-so-fancy
fi
}
alias st='git status'
alias b='git branch'
alias ck='git checkout'
alias add='git add'
alias add.='git add .'
alias tags='git tag -l | sort -V'
alias pull='git pull'
alias rb='git rebase'
alias rbc='git rebase --continue'
alias abort='git rebase --abort'
alias log='git log --graph --pretty=format:'"'"'%Cred%h%Creset -%C(yellow)%d%Creset %C(Normal)%s%Creset %C(white)(%cr) %Creset'"'"' --abbrev-commit'
alias ls='ls -GAF ${colorflag}'
