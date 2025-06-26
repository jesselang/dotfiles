# sudo uses the union of the user's umask and whatever is specified in
# the sudoers config. I don't want root to install software with my restrictive
# umask, so we set $GIVEN_UMASK in ~/.zshrc to preserve the umask that the
# user is given upon login and use it here.
sudo() {
    if [[ -z $GIVEN_UMASK ]]; then
        echo 'error: $GIVEN_UMASK not set' >&2
        return 1
    fi

    local orig_umask=$(umask)
    umask $GIVEN_UMASK && command sudo "$@"
    umask $orig_umask
}
