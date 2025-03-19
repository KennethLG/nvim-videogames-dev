require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" }, -- Lua formatter
		cs = { "csharpier" }, -- C# formatter
    cpp = { "clang-format" }
	},
})

-- Keybinding to manually format files
vim.keymap.set("n", "<leader>F", function()
	require("conform").format({ async = true })
end, { noremap = true, silent = true })
