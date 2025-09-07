

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
find $HOME -maxdepth 1 -type l -exec ls -l {} \; | grep $PWD | cut -d' ' -f 14 | xargs rm
```

Bare repo setup

```sh
mkdir -p ~/.local/share/dotfiles

git clone --bare https://github.com/jesselang/dotfiles.git $HOME/.local/share/dotfiles/bare-repo

# can we skip checkout in favor of restore?
git --git-dir=$HOME/.local/share/dotfiles/bare-repo --work-tree=$HOME checkout

# to restore after dotfiles-uninstall
git --git-dir=$HOME/.local/share/dotfiles/bare-repo --work-tree=$HOME restore .
```

Starting a new shell should provide a `dotfiles` alias to ease working with the
repo and work tree:

```sh
# use sparse checkout to avoid checking out docs and unused files.
dotfiles sparse-checkout set --no-cone \
  '/*' \
  '!/.local/share/dotfiles/emulators' \
  '!/*.md'

# disable parse checkout to update docs, etc.
dotfiles sparse-checkout disable

# update your config before commiting changes
dotfiles config user.email ...
dotfiles ls-files
dotfiles status
dotfiles diff
dotfiles commit

# uninstall dotfiles using alias (consider checking for uncommitted changes first)
dotfiles-uninstall
# without alias
dotfiles ls-files -z | xargs -0 rm
```

I don't want to forget about untracked files altogether, so rather than
setting `status.showUntrackedFiles` to `no`, I've decided to start with a
`.gitignore` file at the root to ignore paths I don't want tracked. This is
likely to be a bit noisy to start, but it's a trade-off I'm willing to make.
