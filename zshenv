export EDITOR=vim
export PYTHONDONTWRITEBYTECODE=1 # *.pyc files are ugly.
export GOPATH=$HOME/dev/go

# OS flags
export OS_NAME=${$(uname -s):l}
export OS_${OS_NAME:u}=1


for ZSHENV in ~/.zsh/env.d/*.zsh; do
    if [ -r $ZSHENV ]; then
        source $ZSHENV
    fi
done

if [[ -f ~/.current/zshenv ]]; then
    source ~/.current/zshenv
fi

# GOPATH may be reset in .current, so wait until things settle to update PATH
export PATH=$PATH:/usr/local/go/bin:$HOME/bin:$GOPATH/bin
