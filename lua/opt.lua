local opt = vim.opt

opt.clipboard = 'unnamedplus'
opt.termguicolors = true
opt.number = true
opt.listchars:append('tab:>-')
opt.listchars:append('space:·')
opt.list = true
opt.colorcolumn = '80'
opt.textwidth = 79
opt.linebreak = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = false
opt.smartindent = true
opt.mouse = 'a'
opt.ignorecase = true
opt.smartcase = true
opt.showcmd = true
opt.splitbelow = true
opt.splitright = true
opt.spelllang = 'en_gb'
opt.wildignorecase = true
opt.hidden = true
opt.backup = false
opt.swapfile = false
opt.updatetime = 300
opt.signcolumn = 'yes'
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
opt.omnifunc = ('syntaxcomplete#Complete')
opt.grepprg = 'rg --vimgrep -S'
opt.grepformat = '%f:%l:%c:%m'
opt.laststatus = 3
opt.pumheight = 10
