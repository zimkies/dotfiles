# Grouper aliases

alias anno='bundle exec annotate -p before'

alias dbg='rake db:test:prepare && bundle exec guard'

alias dbup='wget -O latest.dump `heroku pgbackups:url --app grouper-app` && pg_restore --verbose --clean --no-acl --no-owner -U grouper -d grouper_app_development -h localhost latest.dump'

alias update-staging='heroku pgbackups:restore --app grouper-app HEROKU_POSTGRESQL_AQUA `heroku pgbackups:url --app grouper-app` --confirm grouper-app'


# Run selenium tests on staging
alias test-staging='heroku run rake sauce:test --app grouper-staging'

# Push to staging and run tests
alias push-staging='git push staging master'

# We dump the structure so that circleci can get sql set up correctly
alias dump-structure='rake db:structure:dump'


# Promote from staging to both admin and production
alias promote-all='heroku pipeline:promote --app grouper-staging && heroku pipeline:promote --app grouper-admin'
