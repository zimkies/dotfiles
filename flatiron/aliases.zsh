# activate global virtualenv
eval "$(pyenv init -)"

alias fhactivate='source ~/code/env/bin/activate'
alias fhpgstart='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'

export BLOCKS_MSSQL_CONNECTS=~/.mssql_connections.yaml
export SLACK_LUNCHBOT_ACCESS_TOKEN=xoxb-213483738647-enL3kHDb6sqgDaJWKjxp3TBq
export JELLIES_DEV_ID="bkies"

migrate_all_the_things() {
   python -m patient_manager.scripts.manage migrate upgrade;
   python -m patient_manager.scripts.manage_documents migrate upgrade;
   FH_SETTINGS_FILE=~/code/flatiron/test.cfg python -m patient_manager.scripts.manage migrate upgrade;
   FH_SETTINGS_FILE=~/code/flatiron/test.cfg python -m patient_manager.scripts.manage_documents migrate upgrade;
 }

# generate the list of things being released between 2 different builds
release_log () {
   git log ${1}...${2} --pretty=format:"%H%x09%ae%x09%s" abstraction_model/ chef/ patient_manager/ integration/ dataflow/ ingestor/ | awk '{print "\ -\ ["$1"](https://git.the.flatiron.com/flatironhealth/flatiron/commit/"$1")\ **\("$2"\)** "substr($0, index($0,$3))}' | sed 's/_/\\\_/g'
 }

# Set patient manager debug to true for aloe tests
alias fhdebug="sed -i.bak '110,125 s/debug = false/debug = true/g; s/log_to_console = true/log_to_console = false/g;' ~/code/flatiron/test.cfg; rm ~/code/flatiron/test.cfg.bak"

# Unset patient manager debug to true for aloe tests
alias fhundebug="sed -i.bak '110,125 s/debug = true/debug = false/g; s/log_to_console = false/log_to_console = true/g;' ~/code/flatiron/test.cfg; rm ~/code/flatiron/test.cfg.bak"


alias fh_local_debug="sed -i.bak 's/disable_user_sessions = false/disable_user_sessions = true/g; s/^core_db_url = .*/core_db_url = postgresql\+psycopg2\:\/\/p-pm-postgres-replica\.the\.flatiron\.com\:5432\/core/g' ~/code/flatiron/dev-settings.cfg; rm ~/code/flatiron/dev-settings.cfg.bak;"
alias fh_local_undebug="sed -i.bak 's/disable_user_sessions = true/disable_user_sessions = false/g; s/^core_db_url = .*/core_db_url = postgresql\+psycopg2\:\/\/core\:fifi92\@127\.0\.0\.1\:5432\/core/g' ~/code/flatiron/dev-settings.cfg; rm ~/code/flatiron/dev-settings.cfg.bak;"

alias fhmigrate='migrate_all_the_things'

_adhocpush() {
    branch_name=`git rev-parse --abbrev-ref HEAD`
    echo "Pushing $branch_name to abstech/$branch_name";
    echo 'git push -u origin '"$branch_name"':abstech/'"$branch_name;"
    git push -u origin "$branch_name":abstech/"$branch_name";
}

_adhocdelete() {
    branch_name=`git rev-parse --abbrev-ref HEAD`
    echo "Deleting adhoc remote branch :abstech/$branch_name";

    echo "git push origin abstech/$branch_name";
    git push origin abstech/"$branch_name";
    echo "git branch --unset-upstream";
    git branch --unset-upstream;
}

alias adhocpush="_adhocpush"
alias adhocdelete="_adhocdelete"
