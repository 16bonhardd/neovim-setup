require("bonhardia.remap")
require("bonhardia.set")

vim.cmd 'colorscheme darcula-solid'
vim.cmd 'set termguicolors'

local augroup = vim.api.nvim_create_augroup
local BonhardiaGroup = augroup('Bonhardia', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({ "BufWritePre" }, {
    group = BonhardiaGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.opt.clipboard = "unnamedplus"

if vim.fn.has("wsl") == 1 then
    vim.g.clipboard = {
        name = "wl-clipboard (wsl)",
        copy = {
            ["+"] = 'clip.exe',
            ["*"] = 'clip.exe',
        },
        paste = {
            ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))'
        },
        cache_enabled = true
    }
end
