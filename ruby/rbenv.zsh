# rehash shims
rbenv rehash 2>/dev/null

export RBENV_ROOT=/usr/local/var/rbenv
# export PATH="$HOME/.rbenv/bin:$PATH"
# if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi
eval "$(rbenv init - zsh)"
