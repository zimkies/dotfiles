alias reload!='. ~/.zshrc'

alias dotfiles='cd ~/.dotfiles'

alias e='subl .'

alias anno='bundle exec annotate -p before'

alias dbg='rake db:test:prepare && bundle exec guard'

alias dbup='curl -o latest.dump `heroku pgbackups:url --app grouper-app` && pg_restore --verbose --clean --no-acl --no-owner -U grouper -d grouper_app_development latest.dump'

alias update-staging='heroku pgbackups:restore --app grouper-staging HEROKU_POSTGRESQL_CYAN  `heroku pgbackups:url --app grouper-app` --confirm grouper-staging'


function fname() { find . -iname "*$@*"; }

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"