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



alias fhmigrate='migrate_all_the_things'


# Set up Patient Manager's environment to point to production databases, and disable user sessions to prevent trying to write to the database.
# Useful when trying to debug production issues locally.
_fh_local_debug() {
  replace_disable_user_sessions='s/disable_user_sessions = false/disable_user_sessions = true/g';
  replace_core_db_url='s/^core_db_url = .*/core_db_url = postgresql\+psycopg2\:\/\/p-pm-postgres-replica\.flatiron\.io\:5432\/core/g';
  replace_documents_db_url='s/^documents_db_url = .*/documents_db_url = postgresql\+psycopg2\:\/\/p-documents-postgres-replica\.flatiron\.io\:5432\/core/g';

  sed -i.bak "$replace_disable_user_sessions; $replace_core_db_url; $replace_documents_db_url" ~/code/flatiron/dev-settings.cfg;
  rm ~/code/flatiron/dev-settings.cfg.bak;
}

#sed '/\[logging\]/a\'$'\n''\console_format'$'\n' ~/code/flatiron/dev-settings.cfg | grep -B 3 -A 3 logging
# Set up Patient Manager's environment to point to production databases, and disable user sessions to prevent trying to write to the database.
# Useful when trying to debug production issues locally.
#  replace_console_format='/\[logging\]/\[logging\]\\nconsole_format = succicnt/';
_fh_development_settings() {

  replace_console_format='/\[logging\]/a\'$'\n''\console_format = succinct'$'\n'

  sed -i.bak "$replace_console_format;" ~/code/flatiron/dev-settings.cfg;
  rm ~/code/flatiron/dev-settings.cfg.bak;
}

_fh_clear_development_settings() {

  delete_console_format='/console_format = succinct/d'

  sed -i.bak "$delete_console_format;" ~/code/flatiron/dev-settings.cfg;
  rm ~/code/flatiron/dev-settings.cfg.bak;
}

alias fh_dev_settings="_fh_development_settings"
alias fh_clear_dev_settings="_fh_clear_development_settings"

# Set up Patient Manager's environment back to normal after running fh_local_debug
_fh_local_undebug() {
  replace_disable_user_sessions='s/disable_user_sessions = true/disable_user_sessions = false/g';
  replace_core_db_url='s/^core_db_url = .*/core_db_url = postgresql\+psycopg2\:\/\/core\:fifi92\@127\.0\.0\.1\:5432\/core/g';
  replace_documents_db_url='s/^documents_db_url = .*/documents_db_url = postgresql\+psycopg2\:\/\/documents\:fifi92\@127\.0\.0\.1\:5432\/documents/g';

  sed -i.bak "$replace_disable_user_sessions; $replace_core_db_url; $replace_documents_db_url" ~/code/flatiron/dev-settings.cfg;

  rm ~/code/flatiron/dev-settings.cfg.bak;
}

alias fh_local_debug="_fh_local_debug"
alias fh_local_undebug="_fh_local_undebug"

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
