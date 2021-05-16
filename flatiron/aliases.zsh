# activate global virtualenv
eval "$(pyenv init -)"

alias fh2activate='source ~/code/env/bin/activate'
alias fh2deactivate='source ~/code/env/bin/deactivate'

alias fh3activate='source ~/code/env3/bin/activate'
alias fh3deactivate='source ~/code/env3/bin/deactivate'

alias fh2008activate='source ~/code/env20.08/bin/activate'
alias fh2008deactivate='source ~/code/env20.08/bin/deactivate'

alias fhactivate='source ~/code/env3_next_next/bin/activate'
alias fhdeactivate='source ~/code/env3_next_next/bin/deactivate'

alias ansibleactivate='source ~/code/ansible/bin/activate'
alias ansibledeactivate='source ~/code/ansibl/bin/deactivate'

alias fhpgstart='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'

# RDS documents database
alias psql_documents_rds='psql -h s-documents.cemaxvjhe85e.us-east-1.rds.amazonaws.com -d documents -U bkies '

alias withprod='OVERRIDE_RUNNING_WITH_PHI=1 FH_SETTINGS_FILE=~/flatiron_settings/prod.cfg'
alias withbetterform='FH_SETTINGS_FILE=~/code/flatiron/research/bkies/settings/a_better_form.cfg'
alias withmultitababstraction='FH_SETTINGS_FILE=~/code/flatiron/research/bkies/settings/multitab_abstraction.cfg'
alias withaloe='FH_SETTINGS_FILE=~/code/flatiron/research/bkies/settings/aloe.cfg'
alias withtest='FH_SETTINGS_FILE=~/code/flatiron/test.cfg'
alias withdev='FH_SETTINGS_FILE=~/flatiron_settings/dev.cfg'

# Run a Patient Manager Validator Service test app (useful when running aloe tests which need access to a validator service)
alias pmvs_testapp='FH_SETTINGS_FILE=~/flatiron_settings/validator_service_testing.cfg python -m patient_manager_validator_service.main'

alias celery_queueing='celery worker -A abstraction_worker_celery.app -l info -Q monitoring,initiate_export_data,celery,process_queue_patients_request,queue_patients_request_completed'
alias celery_dataflow='celery worker -A dataflow_celery.app -l info -Q initiate_export_data,celery,monitoring'
alias celery_dataissue='celery worker -A abstraction_worker_celery.app -l info -Q initiate_export_data,celery,process_draft_flags_request,draft_flags_request_completed'


# generate the list of things being released between 2 different builds
release_log () {
   git log ${1}...${2} --pretty=format:"%H%x09%ae%x09%s" abstraction_model/ chef/ patient_manager/ integration/ dataflow/ ingestor/ | awk '{print "\ -\ ["$1"](https://git.the.flatiron.com/flatironhealth/flatiron/commit/"$1")\ **\("$2"\)** "substr($0, index($0,$3))}' | sed 's/_/\\\_/g'
 }

# Set patient manager debug to true for aloe tests
alias fhdebug="sed -i.bak '128,146 s/serve_static_assets_directly = false/serve_static_assets_directly = true/g; s/log_to_console = true/log_to_console = false/g;' ~/code/flatiron/test.cfg; rm ~/code/flatiron/test.cfg.bak"

# Unset patient manager debug to true for aloe tests
alias fhundebug="sed -i.bak '128,146 s/serve_static_assets_directly = true/serve_static_assets_directly = false/g; s/log_to_console = false/log_to_console = true/g;' ~/code/flatiron/test.cfg; rm ~/code/flatiron/test.cfg.bak"

alias pmkarma="karma start patient_manager/patient_manager/tests/js/karma.conf.js"

patient_manager_es_lint_fix() {
  file_to_lint=$1
  eslint -c patient_manager/eslintrc.js "$1" --fix
}

alias pmjslint="patient_manager_es_lint_fix"

patient_manager_migrate_downgrade() {
  version_to_downgrade=$1

  echo "Downgrading Patient Manager's development and test databases to $version_to_downgrade"

  python -m abstraction_model.scripts.manage migrate downgrade "$version_to_downgrade";
  FH_SETTINGS_FILE=~/code/flatiron/test.cfg python -m abstraction_model.scripts.manage migrate downgrade "$version_to_downgrade";
}

patient_manager_migrate_upgrade() {
   python -m abstraction_model.scripts.manage migrate upgrade;
   python -m abstraction_model.scripts.manage_documents migrate upgrade;
   FH_SETTINGS_FILE=~/code/flatiron/test.cfg python -m abstraction_model.scripts.manage migrate upgrade;
   FH_SETTINGS_FILE=~/code/flatiron/test.cfg python -m abstraction_model.scripts.manage_documents migrate upgrade;
 }


alias testenv_pmm='FH_SETTINGS_FILE=~/code/flatiron/test.cfg python -m patient_manager.scripts.manage'
alias pmm='python -m patient_manager.scripts.manage'
alias amm='python -m abstraction_model.scripts.manage'
alias pmup='patient_manager_migrate_upgrade'
alias pmdown='patient_manager_migrate_downgrade'
alias pmclear_cache='rm -rf /Users/bkies-mbp/code/flatiron/patient_manager/patient_manager/static/cache/'

# Unit test patient manager test
alias pmut='pytest /Users/bkies-mbp/code/flatiron/patient_manager/patient_manager/tests/unit/ -k '
alias amut='pytest /Users/bkies-mbp/code/flatiron/abstraction_model/abstraction_model/tests/unit/ -k '


# Set up Patient Manager's environment to point to production databases, and disable user sessions to prevent trying to write to the database.
# Useful when trying to debug production issues locally.
_fh_local_debug() {
  replace_disable_user_sessions='s/disable_user_sessions = false/disable_user_sessions = true/g';
  replace_core_db_url='s/^core_db_url = .*/core_db_url = postgresql\+psycopg2\:\/\/p-pm-postgres-replica\.flatiron\.io\:5432\/core/g';
  replace_documents_db_url='s/^documents_db_url = .*/documents_db_url = postgresql\+psycopg2\:\/\/p-documents-postgres-replica\.flatiron\.io\:5432\/documents/g';

  sed -i.bak "$replace_disable_user_sessions; $replace_core_db_url; $replace_documents_db_url" ~/code/flatiron/dev-settings.cfg;
  rm ~/code/flatiron/dev-settings.cfg.bak;
}


# Set up Patient Manager's environment back to normal after running fh_local_debug
_fh_local_undebug() {
  replace_disable_user_sessions='s/disable_user_sessions = true/disable_user_sessions = false/g';
  replace_core_db_url='s/^core_db_url = .*/core_db_url = postgresql\+psycopg2\:\/\/core\:fifi92\@127\.0\.0\.1\:5432\/core/g';
  replace_documents_db_url='s/^documents_db_url = .*/documents_db_url = postgresql\+psycopg2\:\/\/documents\:fifi92\@127\.0\.0\.1\:5432\/documents/g';

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
    echo "git push origin --delete abstech/$branch_name";
}

alias adhocpush="_adhocpush"
alias adhocdelete="_adhocdelete"


# Run patient manager aloe tests with less typing, and automatically makes and cleans up changes to the test settings
# usage: `aloe <feature-name> -n <test-numbers-comma-separated>`
aloe_func_pm() {
  fhdebug;

  # Pass all other arguments to aloe
  aloe-wrapper patient_manager "$1".feature "${@:2}" -s;
  fhundebug;
}

alias pmaloe='aloe_func_pm'


# start postgres server
alias pgstart='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'

# start patient manager locally (requires virtual environment and psql is started)
alias pmapp='python -m patient_manager.app'

# start patient manager using gunicorn with 4 processes. Helps speed up page loads
alias pmgunicorn='gunicorn patient_manager.app:app --workers=4'
alias fh2='cd ~/code/flatiron; fh2activate'
alias fh3='cd ~/code/flatiron; fh3activate'
alias fh='cd ~/code/flatiron; fh2008activate'
alias pm='fh; cd ~/code/flatiron/patient_manager/patient_manager;'
alias ade='fh; cd ~/code/flatiron/abstraction_demand_estimator/abstraction_demand_estimator;'
alias get_d_core_assumed_admin_credentials='~/.aws/with-assumed-abstech-admin aws s3 cp s3://flatironhealth-eng-secrets/radar/postgresql-admin-users/d-core .'
