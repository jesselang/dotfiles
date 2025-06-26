

What is `$HOME/.current`?
-------------------------

See the profiles README.


In 2025, I switched from a custom installation script that creates symlinks to
using a bare repo approach. Migration involves removing the symlinks from
$HOME before proceeding with the base repo install method.

```sh
# change to dotfiles repo with working files
cd path/to/dotfiles

# find symlinks in $HOME that are sourced from dotfiles repo
find $HOME -maxdepth 1 -type l -exec ls -l {} \; | grep $PWD | cut -d' ' -f 14
## TODO add xargs to remove
```
