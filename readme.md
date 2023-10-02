# Dotfiles

My dotfiles.

## Install

```sh
./bootstrap.sh
```

This script will link the dotfiles in this repository with the homedir. It's basically equivalent to [GNU Stow](https://www.gnu.org/software/stow/).
It should be ran every time a new file is added.

This script is safe, if it finds conflicts, it will ask what to do.
It won't link files that contain my name unless `$USER` is `getkey` or `mourerj`.
