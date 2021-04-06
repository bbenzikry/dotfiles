# themer - theme installation instructions

## emacs

Copy (or symlink) the generated theme file into `~/.emacs.d/`:

    cp 'emacs/snazzy-theme.el' ~/.emacs.d/

Then load the desired theme in `init.el`:

    (load-theme 'snazzy t)