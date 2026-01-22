return {
	"everviolet/nvim",
	name = "evergarden",
	priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
	opts = {
		theme = {
			variant = "fall", -- 'winter'|'fall'|'spring'|'summer'
			accent = "green",
		},
		editor = {
			transparent_background = vim.g.transparent_background,
			override_terminal = true,
			sign = { color = "none" },
			float = {
				color = "mantle",
				solid_border = false,
			},
			completion = {
				color = "surface0",
			},
		},
		style = {
			tabline = { "reverse" },
			search = { "italic", "reverse" },
			incsearch = { "italic", "reverse" },
			types = { "italic" },
			keyword = { "italic" },
			comment = { "italic" },
		},
		integrations = {
			blink_cmp = true,
			cmp = true,
			fzf_lua = true,
			gitsigns = true,
			indent_blankline = { enable = true, scope_color = "green" },
			mini = {
				enable = true,
				animate = true,
				clue = true,
				completion = true,
				cursorword = true,
				deps = true,
				diff = true,
				files = true,
				hipatterns = true,
				icons = true,
				indentscope = true,
				jump = true,
				jump2d = true,
				map = true,
				notify = true,
				operators = true,
				pick = true,
				starters = true,
				statusline = true,
				surround = true,
				tabline = true,
				test = true,
				trailspace = true,
			},
			nvimtree = true,
			rainbow_delimiters = true,
			symbols_outline = true,
			telescope = true,
			which_key = true,
			neotree = true,
		},
		overrides = {
			Normal = {
				"#fddce3",
				"#1d2021",

				-- Additional highlight options can be included here
				style = { "bold", "italic" },
			},
			Keyword = {
				fg = "#ce96de",
				bg = "#ae45be",
			},
		},
		color_overrides = {},
	},
}
