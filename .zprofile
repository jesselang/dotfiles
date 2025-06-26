if [[ $TMUX ]]; then
    # profile already loaded before tmux started
    return
fi

if [[ -f ~/.current/zprofile ]]; then
    source ~/.current/zprofile
fi
