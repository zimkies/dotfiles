alias reload!='. ~/.zshrc'

alias dotfiles='cd ~/.dotfiles'
alias edotfiles='cd ~/.dotfiles && e'

alias e='subl .'

function fname() { find . -iname "*$@*"; }

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"