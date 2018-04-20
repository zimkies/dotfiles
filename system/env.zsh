# Only set this if we haven't set $EDITOR up somewhere else previously.
if [[ "$EDITOR" == "" ]] ; then
  # Use sublime for my editor.
  export EDITOR='vim'
fi

# Setup vi as our editor for the command line
set -o vi
# But still allow history search
bindkey '^R' 'history-incremental-search-backward'
