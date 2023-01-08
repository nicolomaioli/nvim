local o = vim.o
local opt = vim.opt

opt.shm:append('I')
o.backup = false
o.clipboard = 'unnamedplus'
o.colorcolumn = '80'
o.expandtab = false
o.grepformat = '%f:%l:%c:%m'
o.grepprg = 'rg --vimgrep -S'
o.hidden = true
o.ignorecase = true
o.laststatus = 3
o.linebreak = true
o.list = true
opt.listchars:append('space:·')
opt.listchars:append('tab:>-')
o.number = true
o.pumheight = 10
o.shiftwidth = 4
o.showcmd = true
o.signcolumn = 'yes'
o.smartcase = true
o.smartindent = true
o.softtabstop = 4
o.spelllang = 'en_gb'
o.splitbelow = true
o.splitright = true
o.swapfile = false
o.tabstop = 4
o.termguicolors = true
o.textwidth = 79
o.updatetime = 300
o.wildignorecase = true
opt.completeopt = { 'menu', 'menuone', 'noselect' }
o.background = 'dark'
