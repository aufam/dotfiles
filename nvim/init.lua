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

function RunCommandInNewBuffer(cmd)
	vim.cmd("new") -- Open new buffer
	vim.cmd("setlocal buftype=nofile bufhidden=wipe noswapfile") -- Optional: Make it a scratch buffer
	vim.cmd("read !" .. cmd) -- Read command output
end

vim.api.nvim_create_user_command("RunCmd", function(opts)
	RunCommandInNewBuffer(opts.args)
end, {
	nargs = 1,
	complete = function(_, line)
		-- Use shell completion: get suggestions using 'compgen' (bash-specific)
		local comp = io.popen("compgen -c " .. line)
		if not comp then
			return {}
		end

		local results = {}
		for cmd in comp:lines() do
			table.insert(results, cmd)
		end
		return results
	end,
})

-- Example usage: RunCommandInNewBuffer("ls -la")
require("config.vim")

local version = vim.version()
if version.major > 0 or version.minor >= 10 then
	require("config.lazy")
	vim.cmd.colorscheme("rose-pine")
end

require("config.remap")
EnableTransparent()
