# Git
export EDITOR='subl -w'
export GIT_EDITOR='emacs'
export GIT_MERGE_AUTOEDIT=no

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"


# Set up libSVM
export PYTHONPATH=$PYTHONPATH:$HOME/lib/python
export PATH=$PATH:$HOME/lib

# Set up Postgresql
export PATH=/Applications/Postgres.app/Contents/MacOS/bin:$PATH

# Increase Scala PermGen in SBT
# http://stackoverflow.com/questions/8331135/transient-outofmemoryerror-when-compiling-scala-classes
export SBT_OPTS=-XX:MaxPermSize=256m