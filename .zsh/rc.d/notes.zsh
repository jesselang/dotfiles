# https://dev.to/ricardomol/note-taking-from-the-command-line-156/comments/10hi
notes() {
  if [ ! -z "$1" ]; then
    # Using the "$@" here will take all parameters passed into
    # this function so we can place everything into our file.
    echo "$@" >> "$HOME/NOTES.md"
  else
    # If no arguments were passed we will take stdout and place
    # it into our notes instead.
    cat - >> "$HOME/NOTES.md"
  fi
}
