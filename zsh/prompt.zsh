autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

git_branch() {
  echo $($git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
  st=$($git status 2>/dev/null | tail -n 1)
  if [[ $st == "" ]]
  then
    echo ""
  else
    if [[ "$st" =~ ^nothing ]]
    then
      echo "on %{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
    else
      echo "on %{$fg_bold[red]%}$(git_prompt_info)%{$reset_color%}"
    fi
  fi
}

git_prompt_info () {
 ref=$($git symbolic-ref HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "${ref#refs/heads/}"
}

unpushed () {
  $git cherry -v @{upstream} 2>/dev/null
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo " "
  else
    echo " with %{$fg_bold[magenta]%}unpushed%{$reset_color%} "
  fi
}

directory_name() {
  echo "%{$fg_bold[cyan]%}%1/%\/%{$reset_color%}"
}

# Other good prompt options:
#  ➤
#  ॐ
#  ओ
# export PROMPT=$'\n$(directory_name) $(git_dirty)$(need_push)\n%{$reset_color%} ॐ  '

set_prompt () {
  export RPROMPT="%{$fg_bold[cyan]%}%{$reset_color%}"
}



virtualenv_prompt () {
  if [ -z "$VIRTUAL_ENV" ]
  then
    echo ""
  else
    echo "($VIRTUAL_ENV)"
  fi

}

precmd() {
  # title "zsh" "%m" "%55<...<%~"


  export PROMPT=$'\n$(virtualenv_prompt) $(directory_name) %{$fg_bold[green]%}$(git_branch)\n%{$reset_color%} ॐ  '
  # Uncomment this line to enable much nicer git tracking.
  # This is incredibly slow on the monorepo though, so it's disabled by default.
  # export PROMPT=$'\n$(directory_name) $(git_dirty)$(need_push)\n%{$reset_color%} ॐ  '
  # export PROMPT=$'\n$(directory_name) %{$fg_bold[green]%}$(git_branch)\n%{$reset_color%} ॐ  '
  set_prompt
}
