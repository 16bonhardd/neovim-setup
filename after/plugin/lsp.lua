local lsp = require("lsp-zero")

require('mason').setup({})

require('mason-lspconfig').setup({
    ensure_installed = {
        'rust_analyzer',
        'lua_ls',
        'jdtls',
        'clangd',
    },
    handlers = {
        lsp.default_setup,
        jdtls = lsp.noop,
        lua_ls = function()
            local lua_opts = lsp.nvim_luaUls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
    }
})


lsp.preset("recommended")


-- Fix Undefined global 'vim'
lsp.nvim_workspace()

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_format = lsp.cmp_format()

cmp.setup({
    formatting = cmp_format,
    mapping = cmp.mapping.insert({
        ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    }),
})


lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("i", "<A-CR>", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<A-CR>", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = {
        ['lua_ls'] = { 'lua' },
        ['nvim-jdtls'] = { 'java' },
        ['rust-analyzer'] = { 'rs' },
        ['clangd'] = { 'cpp', 'c' },
    }
})

-- fixes semantic highlighting conflicts
lsp.set_server_config({
    on_init = function(client)
        client.server_capabilities.semanticTokensProvider = nil
    end,
})

-- needed for nvim-jdtls
local cmp_action = lsp.cmp_action()

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setuprequire('lsp-zero')({
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'buffer',  keyword_length = 3 },
        { name = 'luasnip', keyword_length = 2 },
    },
    mapping = {
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    }
})

vim.diagnostic.config({
    virtual_text = true
})
