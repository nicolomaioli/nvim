# nvim

Use the [dotfiles](https://github.com/nicolomaioli/dotfiles) repo to install
and configure `nvim`.

## LSP, DAP, Formatters, and Linters

See `h: mason`, configuration is done manually because I didn't like the
overhead of `mason-lspconfig`.

LSP, DAP, formatters and linters are currently installed manually with
`:MasonInstall`. I know there are ways to automate that but is not enough of an
ballocking to justify the effort.

### LSP

- ansible-language-server
- dockerfile-language-server
- gopls
- lua-language-server
- pyright
- terraform-ls
- typescript-language-server
- yaml-language-server

### DAP

- delve
- debugpy

### Formatter

- black
- prettierd
- luaformatter

### Linter

- eslint_d
- ansible-lint
