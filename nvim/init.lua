function EnableTransparent()
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
	vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
end

function GoTo(str)
	local path, line = str:match("^(.-):(%d+)")
	if path and line then
		vim.cmd("edit " .. path)
		vim.cmd(line)
	else
		print("Invalid format:", str)
	end
end

require("config.vim")

local version = vim.version()
local no_lazy = vim.env.NO_LAZY

if (version.major > 0 or version.minor >= 10) and not no_lazy then
	require("config.lazy")
	vim.cmd.colorscheme("rose-pine")
else
	vim.notify(
		"lazy.nvim and colorscheme disabled: " .. (no_lazy and "NO_LAZY env set" or "Neovim < 0.10"),
		vim.log.levels.WARN
	)
	vim.cmd.colorscheme("unokai")
end

require("config.remap")
EnableTransparent()
