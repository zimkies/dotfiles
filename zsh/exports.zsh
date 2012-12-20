
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

# rbenv shims
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
