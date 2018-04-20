
# VirtualEnvWrapper initialization
# http://virtualenvwrapper.readthedocs.org/en/latest/install.html
eval "$(pyenv init -)"

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Workspace

# We use pyenv to mananage environments, so no longer activate virtualenv
# source /usr/local/bin/virtualenvwrapper.sh

