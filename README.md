# fish-e

fish-e explore the filesystem with [fzf].

## Install

With [fisherman]

```
fisher toshiya240/fish-e
```

## FZF binary

This plugin will fail if the `fzf` binary is not detected in your `PATH`.

The recommended means of installing `fzf` is through your respective package managers.

## Usage

```fish
e [dir]
```

* start to explore at the dir specified by the arg or the current dir.
* during to explore...
    * cd if you select a dir.
    * open if you select a file.
    * finish to explore if you select the "." or cancel fzf.

[fisherman]: https://github.com/fisherman/fisherman
[fzf]: https://github.com/junegunn/fzf
