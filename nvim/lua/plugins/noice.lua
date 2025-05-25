return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		-- add any options here
	},
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		"rcarriga/nvim-notify",
		"hrsh7th/nvim-cmp",
	},
	config = function()
		require("noice").setup({
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
				documentation = {
					view = "hover",
					opts = { -- lsp_docs settings
						lang = "markdown",
						replace = true,
						render = "plain",
						format = { "{message}" },
						position = { row = 2, col = 2 },
						size = {
							max_width = vim.api.nvim_win_get_width(0),
							max_height = 15,
						},
						border = {
							style = "rounded",
						},
						win_options = {
							concealcursor = "n",
							conceallevel = 3,
							winhighlight = {
								Normal = "CmpPmenu",
								FloatBorder = "DiagnosticSignInfo",
							},
						},
					},
				},
			},
		})
	end,
}
