-- Disable color column on non-file buffers
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("NoColorColumn", { clear = true }),
    pattern = { "startup", "lazy", "NvimTree", "dashboard", "alpha", "help", "qf" },
    callback = function()
        vim.opt_local.colorcolumn = "" -- Set the colorcolumn to empty (disable it)
    end,
})

