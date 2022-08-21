# nvim

Current nvim configuration in lua.

## Ansible

After installing Ansible, add the `community-general` collection:

```sh
ansible-galaxy collection install community.general
```

Use the included Ansible playbook to install all dependencies:

```sh
ansible-pull -K --accept-host-key -U git@github.com:nicolomaioli/nvim.git ansible/local.yml
```

Optionally add the `-C` flag to checkout a specific branch.

## LSP, DAP, Formatters, and Linters

See `h: mason`, configuration is done manually because I didn't like the
overhead of `mason-lspconfig`.

### LSP

- ansible-language-server
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
