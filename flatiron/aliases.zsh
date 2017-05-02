# activate global virtualenv
alias fhactivate='source ~/code/env/bin/activate'
alias fhpgstart='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'

export BLOCKS_MSSQL_CONNECTS=~/mssql_connections.yaml

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
alias fhdebug="sed -i.bak '79,95 s/debug = false/debug = true/g' ~/code/flatiron/test.cfg; rm ~/code/flatiron/test.cfg.bak"

# Unset patient manager debug to true for aloe tests
alias fhundebug="sed -i.bak '79,95 s/debug = true/debug = false/g' ~/code/flatiron/test.cfg; rm ~/code/flatiron/test.cfg.bak"

alias fhmigrate='migrate_all_the_things'

