# ZSH fast command-not-found plugin for OSX

The purpose of this plugin is to provide a faster alternative to
`oh-my-zsh` / `prezto` one, which runs multiple useless checks, and
runs `brew` command within `zshrc`.

The problem is `brew` commands are really slow (0.5~2s) and cause
huge zsh slowdown load time.

This plugin check for `brew command-not-found` dynamically, when
a wrong command has been typed. This cause a latency each time a
a not found command is typed.
However, given the great auto-correction and syntax highlighting
features of zsh, this is something that rarely happens, and which
is less disturbing because we can stop it with <ctrl><v> easily.


## Installation

You can use this plugin using zplug :

```bash
zplug "Tireg/zsh-macos-command-not-found", if:"[[ "${OSTYPE}" == 'darwin'* ]]";
```


## Requirements

This plugin is only meant to be sourced on macOS. Be sure to check
your OS before sourcing it (like in Installation step with zplug)

You should install [`brew`](https://brew.sh/index_fr), and tap
[`homebrew/command-not-found`](https://github.com/Homebrew/homebrew-command-not-found)
to make this plugin useful.
