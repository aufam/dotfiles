return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = {
				-- vim/nvim related
				"vim",
				"vimdoc",
				"lua",

				-- programming languages
				"c",
				"cpp",
				"cmake",
				"python",
				"go",
				"gomod",
				"gosum",
				"rust",
				"zig",
				"javascript",
				"typescript",
				"html",

				-- scripting
				"bash",
				"fish",
				"tmux",
				"make",
				"json",
				"yaml",
				"xml",
				"toml",
				"regex",

				-- stack
				"gitignore",
				"dockerfile",
				"nginx",
				"proto",
				"sql",

				-- text
				"markdown",
				"doxygen",
			},
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
