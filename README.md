# nvim

Current nvim configuration in lua.

## Ansible

Use the included Ansible playbook to install all dependencies:

```sh
ansible-pull -K --accept-host-key -U git@github.com:nicolomaioli/nvim.git ansible/local.yml
```

Optionally add the `-C` flag to checkout a specific branch.

## lsp

- gopls
- yaml-language-server
- lua-language-server
- terraform-ls
- tsserver
- pyright
- efm-langserver
	- eslint_d
	- prettier
	- black
	- lua-format

## lua-language-server

Create a `vendors` folder, clone the repo and build it.
