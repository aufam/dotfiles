return {
	"nvim-lualine/lualine.nvim",
	branch = "master",
	config = function()
		require("lualine").setup({
			options = { theme = "auto", section_separators = "", component_separators = "" },
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							local map = {
								["NORMAL"] = "N",
								["INSERT"] = "I",
								["VISUAL"] = "V",
								["V-LINE"] = "V-L",
								["V-BLOCK"] = "V-B",
								["REPLACE"] = "R",
								["COMMAND"] = "C",
								["SHELL"] = "S",
								["TERMINAL"] = "T",
								["SELECT"] = "S",
							}
							return map[str] or str:sub(1, 1)
						end,
					},
					{
						function()
							local str = require("noice").api.statusline.mode.get()

							local rec = str:match("recording @(%a)")
							if rec then
								return "  @" .. rec
							end

							local mode_map = {
								["-- V-LINE --"] = "V-L",
								["-- V-BLOCK --"] = "V-B",
								["-- REPLACE --"] = "R",
								["-- COMMAND --"] = "C",
								["-- SELECT --"] = "S",
								["-- EX --"] = "EX",
								["-- TERMINAL --"] = "TERM",
							}

							return mode_map[str] or ""
						end,
						cond = function()
							return require("noice").api.statusline.mode.has()
						end,
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
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
