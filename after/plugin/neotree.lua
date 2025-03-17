require("neo-tree").setup({
	close_if_last_window = true, -- Close neo-tree if it's the last window
	popup_border_style = "rounded",
	enable_git_status = true,
	enable_diagnostics = true,
	filesystem = {
		filtered_items = {
			visible = true, -- Show hidden files
			hide_dotfiles = false,
			hide_gitignored = false,
		},
		follow_current_file = {
			enabled = true, -- Automatically focus the file you're working on
		},
	},
	buffers = {
		follow_current_file = {
			enabled = true, -- Focus the buffer you're working on
		},
	},
	event_handlers = {
		{
			event = "file_open_requested",
			handler = function()
				-- auto close
				-- vim.cmd("Neotree close")
				-- OR
				require("neo-tree.command").execute({ action = "close" })
			end,
		},
	},
})

-- Keybindings

vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { noremap = true })

