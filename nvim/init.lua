function EnableTransparent()
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

require("config.vim")

local version = vim.version()
if version.major > 0 or version.minor >= 10 then
	require("config.lazy")
	vim.cmd.colorscheme("rose-pine")
end

require("config.remap")
EnableTransparent()
