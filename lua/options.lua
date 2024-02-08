local opt = vim.opt

opt.background = "dark"

opt.clipboard = "unnamedplus"
opt.mouse = "a"
opt.wrap = false
opt.number = true
opt.signcolumn = "yes:1"
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"

vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4


vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.ignorecase = true
vim.opt.smartcase = true
