# nvim

## Quick Start with Nix

To quickly set up this Neovim configuration using Nix:

```bash
nix run github:clydon/nvim#setup-nvim
```

This will copy the configuration files to `~/.config/nvim/`.

To enter a development environment with all necessary tools:

```bash
nix develop github:connoralydon/nvim/main --no-write-lock-file --refresh
```

## Usage

Once in the development environment, you can use `nvim` to start Neovim with this configuration.

## Notes

## TODO

1. ~~add `nix develop`~~ (Done)
2. compare:

- quickstart.nvim
- nvchad
- lazyvim

## Included Tools

The development environment includes:

- Neovim
- GNU Make
- Clang
- fzf
- Node.js 23
- Go
