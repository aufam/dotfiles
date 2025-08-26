local function lsp_servers()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if next(clients) == nil then
		return ""
	end
	return " " .. table.concat(
		vim.tbl_map(function(client)
			return client.name
		end, clients),
		" "
	)
end

local function is_readonly()
	if not vim.bo.modifiable or vim.bo.readonly then
		return "readonly"
	else
		return ""
	end
end

return {
	"nvim-lualine/lualine.nvim",
	branch = "master",
	dependencies = {
		"SmiteshP/nvim-navic",
	},
	config = function()
		local navic = require("nvim-navic")
		require("lualine").setup({
			options = { theme = "auto", section_separators = "", component_separators = "" },
			winbar = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					is_readonly,
					"filetype",
					{
						function()
							return navic.is_available() and navic.get_location() or ""
						end,
						cond = function()
							return navic.is_available()
						end,
					},
				},
				lualine_x = { lsp_servers, "encoding", "fileformat" },
				lualine_y = {},
				lualine_z = {},
			},
			sections = {
				lualine_a = {
					"mode",
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
						show_filename_only = true,
						hide_filename_extension = false,
						show_modified_status = true,
						use_mode_colors = true,
						mode = 4,
						buffers_color = { active = "lualine_b_normal", inactive = "lualine_c_inactive" },
						symbols = {
							modified = " •",
							alternate_file = "",
							directory = "",
						},
					},
				},
				lualine_c = {},
				lualine_x = { "diagnostics", "diff" },
				lualine_y = { "branch" },
				lualine_z = { "progress", "location" },
			},
		})
	end,
}
