return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = { theme = "auto", section_separators = "", component_separators = "│" },
			sections = {
				lualine_a = {
					-- "mode",
					{
						require("noice").api.statusline.mode.get,
						cond = require("noice").api.statusline.mode.has,
					},
				},
				lualine_b = {
					{
						"buffers",
						symbols = { modified = " ●" },
						buffers_color = { active = "lualine_b_normal", inactive = "lualine_c_inactive" },
						show_filename_only = true,
						hide_filename_extension = false,
						show_modified_status = true,
					},
				},
				lualine_c = {},
				lualine_x = {
					"encoding",
					"fileformat",
					"filetype",
					"branch",
					"diff",
				},
				lualine_y = {},
				lualine_z = { "progress", "location" },
			},
		})
	end,
}
