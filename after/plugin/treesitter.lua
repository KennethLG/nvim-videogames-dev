
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c_sharp" }, -- Install C# support
    highlight = { enable = true }, -- Enable syntax highlighting
    indent = {
	    enable = true,
    }
}

