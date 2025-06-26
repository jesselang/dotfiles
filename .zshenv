export EDITOR=vim
export LESS="--raw --no-init --quit-if-one-screen"
export PYTHONDONTWRITEBYTECODE=1 # *.pyc files are ugly.
export CGO_ENABLED=0 # static binaries by default, thankyouverymuch
export GOPATH=$HOME/.local/go # out of sight, out of mind

# choose your $PATH
export PATH=$PATH:$GOPATH/bin:$HOME/bin

# OS flags: "linux", "darwin", etc.
export OS_NAME=${$(uname -s):l}
export OS_${OS_NAME:u}=1

for ZSHENV in ~/.zsh/env.d/*.zsh ~/.profiles/_os/$OS_NAME/zshenv; do
    if [[ -r $ZSHENV ]]; then
        source $ZSHENV
    fi
done

if [[ -r ~/.current/zshenv ]]; then
    source ~/.current/zshenv
fi
