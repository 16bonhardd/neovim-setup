-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        -- This file can be loaded by calling `lua require('plugins')` from your init.vim
        'nvim-telescope/telescope.nvim', tag = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- use { 'Carcuis/darcula' }
    -- use { 'kl4mm/darcula' }
    -- use { 'doums/darcula' }
    use { "16bonhardd/darcula.nvim", requires = "rktjmp/lush.nvim" }
    -- use({
    -- "folke/trouble.nvim",
    -- config = function()
    -- require("trouble").setup {
    -- icons = false,
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    -- }
    -- end
    -- })

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end, }
    use("nvim-treesitter/playground")
    use("theprimeagen/harpoon")
    use("theprimeagen/refactoring.nvim")
    use("mbbill/undotree")
    use("tpope/vim-fugitive")
    use("nvim-treesitter/nvim-treesitter-context")
    use("mfussenegger/nvim-dap")
    use("mfussenegger/nvim-jdtls")
    use("nvim-lua/plenary.nvim")
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {                            -- Optional
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    }

    -- use("folke/zen-mode.nvim")
    use("terrortylor/nvim-comment")
    use {
        'saecki/crates.nvim',
        tag = 'v0.3.0',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('crates').setup()
            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        end,
    }
    -- use { "akinsho/toggleterm.nvim", tag = '*' }
    use { "lewis6991/gitsigns.nvim" }
end)
