# zsh-lazy-nvm

Lazy nvm loading with auto use support!

## Requirements

- zsh
- [nvm](https://github.com/nvm-sh/nvm)

## Install

### Install with [zinit](https://github.com/zdharma/zinit) (recommended)

```sh
zinit light sei40kr/zsh-lazy-nvm
```

### Install with [zplug](https://github.com/zplug/zplug)

```sh
zplug sei40kr/zsh-lazy-nvm
```

## Customization

| Variable                | Default Value | Description                                                                                                           |
| :---------------------- | :------------ | :-------------------------------------------------------------------------------------------------------------------- |
| `LAZY_NVM_SILENT_USE`   | `false`       | Whether to use `--silent` option for `nvm use`. If `true`, it also keeps silence on reverting to nvm default version. |
| `LAZY_NVM_AUTO_INSTALL` | `false`       | Whether to install the local version if it is not already installed.                                                  |

## Similar Projects

- [zsh-nvm](https://github.com/lukechilds/zsh-nvm)
