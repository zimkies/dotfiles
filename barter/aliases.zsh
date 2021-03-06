# Aliases
alias barterenv="source $HOME/Virtualenv/barterenv/bin/activate"
alias barter="cd $HOME/Workspace/barter/"
#alias be="barterenv && barter"
alias bmedia="python manage.py coffee && python manage.py lessc"
alias syncdb="python manage.py syncdb --migrate"
alias upload="git push ssh://zimkies@review.barter.im:29418/barter HEAD:refs/for/master"

alias rmtws="find . -type f \( -iname '*.py' -or  -iname '*.html' -or  -iname '*.js' -or  -iname '*.coffee' \) -print0 | xargs -0 sed -i -e 's/\s\s*$//g'"
alias bmw="bmedia"
alias pipupgrade="pip freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs pip install -U"
