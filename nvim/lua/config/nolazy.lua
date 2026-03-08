local lazypath = vim.fn.stdpath("data") .. "/lazy"

for _, dir in ipairs({
	lazypath .. "/askai.nvim",
	lazypath .. "/gitsigns.nvim",
	lazypath .. "/nvim-treesitter",
	lazypath .. "/nvim-surround",
	lazypath .. "/vim-easy-align",
	lazypath .. "/vim-visual-multi",
	lazypath .. "/nvim-cmp",
	lazypath .. "/cmp-buffer",
	lazypath .. "/cmp-path",
	lazypath .. "/cmp-cmdline",
	lazypath .. "/cmp-nvim-lsp",
	lazypath .. "/cmp_luasnip",
	lazypath .. "/LuaSnip",
}) do
	vim.opt.rtp:append(dir)
end

require("askai").setup({ provider = "gemini" })

require("nvim-surround").setup({})

require("nvim-treesitter.configs").setup({
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
	sync_install = false,
	auto_install = false,
	ignore_install = {},
	modules = {},
	highlight = { enable = true },
	indent = { enable = true },
})

require("gitsigns").setup({
	signs = {
		add = { text = "" }, -- unstaged add
		change = { text = "" }, -- unstaged change
		delete = { text = "" }, -- unstaged delete
		topdelete = { text = "󰐊" },
		changedelete = { text = "󰍴" },
		untracked = { text = "" },
	},
	signs_staged = {
		add = { text = "" }, -- staged add (check-square)
		change = { text = "" }, -- staged change (note)
		delete = { text = "" }, -- staged delete (minus-square)
		topdelete = { text = "󰘚" }, -- staged top delete
		changedelete = { text = "󱗜" }, -- staged change + delete
	},
	preview_config = {
		relative = "cursor",
		row = 1,
		col = 0,
		style = "minimal",
		border = "rounded",
	},
})

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(1) then
				luasnip.jump(1)
			elseif cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			elseif cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "cmdline" },
	}),
})
