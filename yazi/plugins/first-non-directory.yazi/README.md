# first-non-directory.yazi

Jump to the first file ignoring directories.

<https://github.com/user-attachments/assets/f759d0be-c3c3-4708-adeb-7d85d0048099>

## Requirements

- yazi version 0.4

## Installation

```sh
ya pack -a lpanebr/yazi-plugins:first-non-directory
```

## Usage

Add this to your `keymap.toml` to set the keymap for the plugin:

```toml
[[manager.prepend_keymap]]
on   = [ "f", "j" ]
run  = "plugin first-non-directory"
desc = "Jumps to the first file"
```

## Disclaimers

- Tested only with yazi version 0.4.3
