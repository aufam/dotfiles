function EnableTransparent()
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
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
if version.major > 0 or version.minor >= 10 then
	require("config.lazy")
	vim.cmd.colorscheme("gruvbox")
end

require("config.remap")
EnableTransparent()
