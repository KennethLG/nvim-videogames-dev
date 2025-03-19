-- Enable Mason
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "omnisharp", "clangd" },
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
		{ name = "luasnip" }, -- Snippets
		{ name = "buffer" }, -- Text from buffer
	}),
})

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local omnisharp_bin = "C:\\omnisharp\\OmniSharp.dll"

local on_attach = function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }
	client.server_capabilities.documentFormattingProvider = false -- Disable formatting if needed

	-- Telescope-based LSP navigation
	vim.keymap.set("n", "gd", function() telescope_builtin.lsp_definitions({ show_line = true }) end, opts)
	vim.keymap.set("n", "gr", function() telescope_builtin.lsp_references({ show_line = true }) end, opts)
	vim.keymap.set("n", "gi", function() telescope_builtin.lsp_implementations({ show_line = true }) end, opts)
	vim.keymap.set("n", "gt", function() telescope_builtin.lsp_type_definitions({ show_line = true }) end, opts)

	-- Standard LSP keymaps
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

	-- Diagnostics navigation
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

	-- Navigate only errors
	vim.keymap.set("n", "[e", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, opts)
	vim.keymap.set("n", "]e", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, opts)

	-- Show diagnostics popup
	vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, opts)
end

lspconfig.omnisharp.setup({
	use_mono = false, -- Ensure it's using .NET, not Mono
	capabilities = capabilities,
	cmd = { "dotnet", omnisharp_bin },
	on_attach = on_attach,
})
lspconfig.clangd.setup({
  capabilities = capabilities,
  on_attach = on_attach
})
