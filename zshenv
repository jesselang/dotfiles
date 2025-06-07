export EDITOR=vim
export LESS="--raw --no-init --quit-if-one-screen"
export PYTHONDONTWRITEBYTECODE=1 # *.pyc files are ugly.
export CGO_ENABLED=0 # static binaries by default, thankyouverymuch
export GO111MODULE=on # use golang modules
export GOPATH=$HOME/dev/go

# OS flags
export OS_NAME=${$(uname -s):l}
export OS_${OS_NAME:u}=1

for ZSHENV in ~/.zsh/env.d/*.zsh; do
    if [ -r $ZSHENV ]; then
        source $ZSHENV
    fi
done

if [[ -r ~/.current/zshenv ]]; then
    source ~/.current/zshenv
fi

# GOPATH may be reset in .current, so wait until things settle to update PATH
export PATH=$PATH:/usr/local/go/bin:$HOME/bin:$GOPATH/bin
