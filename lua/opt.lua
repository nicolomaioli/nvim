local opt = vim.opt

opt.backup = false
opt.clipboard = 'unnamedplus'
opt.colorcolumn = '80'
opt.expandtab = false
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --vimgrep -S'
opt.hidden = true
opt.ignorecase = true
opt.laststatus = 3
opt.linebreak = true
opt.list = true
opt.listchars:append('space:·')
opt.listchars:append('tab:>-')
opt.mouse = 'a'
opt.number = true
opt.pumheight = 10
opt.shiftwidth = 4
opt.showcmd = true
opt.signcolumn = 'yes'
opt.smartcase = true
opt.smartindent = true
opt.softtabstop = 4
opt.spelllang = 'en_gb'
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.tabstop = 4
opt.termguicolors = true
opt.textwidth = 79
opt.updatetime = 300
opt.wildignorecase = true
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
