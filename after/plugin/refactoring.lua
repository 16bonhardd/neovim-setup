require('refactoring').setup({
    prompt_func_return_type = {
        go = false,
        java = false,

        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
    },
    prompt_func_param_type = {
        go = false,
        java = false,

        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
    },
    printf_statements = {},
    print_var_statements = {},
})

vim.api.nvim_set_keymap("v", "<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
    { noremap = true, silent = true, expr = false })
vim.keymap.set("x", "<leader>re", function() require('refactoring').refactor('Extract Function') end)
vim.keymap.set("x", "<leader>rf", function() require('refactoring').refactor('Extract Function To File') end)
-- Extract function supports only visual mode
vim.keymap.set("x", "<leader>rv", function() require('refactoring').refactor('Extract Variable') end)
-- Extract variable supports only visual mode
vim.keymap.set({ "n", "x" }, "<leader>ri", function() require('refactoring').refactor('Inline Variable') end)
-- Inline var supports both normal and visual mode

vim.keymap.set("n", "<leader>rb", function() require('refactoring').refactor('Extract Block') end)
vim.keymap.set("n", "<leader>rbf", function() require('refactoring').refactor('Extract Block To File') end)
-- Extract block supports only normal mode-- Extract block supports only normal mode
