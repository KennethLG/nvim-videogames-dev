local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup({
    defaults = {
	defaults = {
	    file_ignore_patterns = {
		"Library/.*", "Logs/.*", "MemoryCaptures/.*", "obj/.*", "Temp/.*",
		"Packages/.*", "UserSettings/.*", "ProjectSettings/.*", "Build/.*",
		"%.meta$", "%.csproj$", "%.sln$", "%.unity$", "%.prefab$", "%.mat$", "%.shader$",
		".git/", ".gitignore", ".gitmodules", "node_modules/", "%.dll$", "%.exe$"
	    },
	}
    },
    pickers = {
        find_files = {
            hidden = true, -- Show hidden files
            find_command = { "rg", "--files", "--glob",  "!{.git,Library,Logs,Temp,Build,ProjectSettings,Packages,UserSettings}/*"  }, -- Use ripgrep for finding files
        },
	live_grep = {
	    additional_args = function()
		return {
		    "--hidden",
		    "--glob", "!{Library,Logs,Temp,Build,ProjectSettings,Packages,UserSettings}/*",
		    "--glob", "!*.meta",
		    "--glob", "!*.csproj",
		    "--glob", "!*.sln",
		    "--glob", "!*.dll",
		    "--glob", "!*.exe"
		}
	    end,
	    theme = "dropdown",
	},
        buffers = { theme = "dropdown" },
        help_tags = { theme = "dropdown" },
    },
})

-- Custom Unity Keybindings
vim.keymap.set("n", "<leader>ff", builtin.find_files, { noremap = true, silent = true }) -- Search all files
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { noremap = true, silent = true }) -- Search in files

