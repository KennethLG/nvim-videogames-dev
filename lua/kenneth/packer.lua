-- Install Packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
ensure_packer()

-- Packer Plugins
require("packer").startup(function(use)
	use("wbthomason/packer.nvim") -- Package manager
	use("neovim/nvim-lspconfig") -- LSP config
	use("williamboman/mason.nvim") -- LSP installer
	use("williamboman/mason-lspconfig.nvim") -- Mason LSP integration
	use("hrsh7th/nvim-cmp") -- Autocompletion
	use("hrsh7th/cmp-nvim-lsp") -- LSP source for nvim-cmp
	use("saadparwaiz1/cmp_luasnip") -- Snippets
	use("L3MON4D3/LuaSnip") -- Snippet engine
	use("nvim-treesitter/nvim-treesitter") -- Treesitter
	use("nvim-telescope/telescope.nvim") -- Telescope core
	use("nvim-lua/plenary.nvim") -- Required dependency for Telescope
	use("nvim-telescope/telescope-fzf-native.nvim") -- (Optional) Faster fuzzy searching
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
	})
	use({ "catppuccin/nvim", as = "catppuccin" })
	use({
		"echasnovski/mini.pairs",
		config = function()
			require("mini.pairs").setup()
		end,
	})

	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({})
		end,
	})
	use({
		"RRethy/vim-illuminate",
	})
	use({
		"nvim-lualine/lualine.nvim",
		requires = {
			"nvim-tree/nvim-web-devicons",
		},
	})
	use("stevearc/conform.nvim")
  use("JafarDakhan/vim-gml")
end)
