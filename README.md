# ZSH fast command-not-found plugin for macOS

The purpose of this plugin is to provide a faster alternative to the
`oh-my-zsh` / `prezto` one, which runs multiple useless checks, and
runs `brew` command within `zshrc`.

The problem is `brew` commands are really slow (0.5~2s) and cause
a huge slowdown in zsh load time.

This plugin checks for `brew command-not-found` dynamically, when
a wrong command has been typed. This causes a latency each time a
a not found command is typed.

However, given the great auto-correction and syntax highlighting
features of zsh, this is something that rarely happens, and which
is less disturbing because we can stop it with <ctrl><v> easily.

## Installation

You can use this plugin using zplug :

```bash
zplug "Tireg/zsh-macos-command-not-found"
```

## Requirements

You should install [`brew`](https://brew.sh/index_fr), and tap
[`homebrew/command-not-found`](https://github.com/Homebrew/homebrew-command-not-found) to make this plugin useful.
