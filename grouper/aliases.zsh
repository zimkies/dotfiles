# Grouper aliases

alias anno='bundle exec annotate -p before'

alias dbg='bundle exec rake db:test:prepare && bundle exec guard'

alias dbup='wget -O latest.dump `heroku pgbackups:url --app grouper-app` && pg_restore --verbose --clean --no-acl --no-owner -U grouper -d grouper_app_development -h localhost latest.dump'

alias update-staging='heroku pgbackups:restore --app grouper-app HEROKU_POSTGRESQL_AQUA `heroku pgbackups:url --app grouper-app` --confirm grouper-app'


# Run selenium tests on staging
alias test-staging='heroku run rake sauce:test --app grouper-staging'

alias push-staging='git push staging master'

# We dump the structure so that circleci can get sql set up correctly
alias dump-structure='bundle exec rake db:structure:dump'

# Promote from staging to both admin and production
alias promote-all='heroku pipeline:promote --app grouper-staging && heroku pipeline:promote --app grouper-admin'

# Pull in master and deploy to staging then promote
alias deploy='git pull && git push staging master && promote-all'

# Pull in master and deploy to staging then promote
alias deploy-migrate='git pull && git push staging master && heroku run rake db:migrate --app grouper-staging && heroku restart --app grouper-staging && heroku pipeline:promote --app grouper-staging && heroku pipeline:promote --app grouper-admin && echo "waiting 120 seconds for dynos to restart" && sleep 120 && heroku run rake db:migrate --app grouper-admin && heroku restart --app grouper-admin && heroku restart --app grouper-app'
