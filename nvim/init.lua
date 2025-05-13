require("config.vim")

local version = vim.version()
if version.major > 0 or version.minor >= 10 then
    require("config.lazy")
end

require("config.remap")

vim.cmd.colorscheme("rose-pine")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
