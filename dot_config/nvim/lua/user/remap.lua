local map = vim.keymap.set

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Navigation
map('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })

-- Window management
map('n', '<leader>sv', '<C-w>v', { desc = 'Split window vertically' })
map('n', '<leader>sh', '<C-w>s', { desc = 'Split window horizontally' })
map('n', '<leader>s=', '<C-w>=', { desc = 'Make splits equal size' })
map('n', '<leader>sx', '<cmd>close<CR>', { desc = 'Close current split' })

-- Tab management
map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
map("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
map("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
map("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })
