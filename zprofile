export EDITOR=vim

if [[ $TMUX ]]; then
    # profile already loaded before tmux started
    return
fi

export PATH=$PATH:$HOME/bin:$GOPATH/bin

if [[ -f ~/.current/zprofile ]]; then
    source ~/.current/zprofile
fi
