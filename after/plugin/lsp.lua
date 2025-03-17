-- Enable Mason
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "omnisharp" },
    automatic_installation = true,

})

local cmp = require("cmp")

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body) -- Enable snippets
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(), -- Trigger completion
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
        ["<Tab>"] = cmp.mapping.select_next_item(), -- Navigate suggestions
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- Use LSP as a source
        { name = "luasnip" },  -- Snippets
        { name = "buffer" },   -- Text from buffer
    }),
})

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local omnisharp_bin = "C:\\omnisharp\\OmniSharp.dll"

lspconfig.omnisharp.setup({
    use_mono = false,  -- Ensure it's using .NET, not Mono
    capabilities = capabilities,
    cmd = {"dotnet", omnisharp_bin },
    on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    end
})
