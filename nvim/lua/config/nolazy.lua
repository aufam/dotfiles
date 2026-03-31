local common = require("config.common")

local lazypath = vim.fn.stdpath("data") .. "/lazy"
for _, dir in ipairs({
	lazypath .. "/askai.nvim",
	lazypath .. "/copilot.vim",
	lazypath .. "/gitsigns.nvim",
	lazypath .. "/nvim-autopairs",
	lazypath .. "/nvim-treesitter",
	lazypath .. "/nvim-surround",
	lazypath .. "/plenary.nvim",
	lazypath .. "/telescope.nvim",
	lazypath .. "/vim-easy-align",
	lazypath .. "/vim-visual-multi",
	lazypath .. "/non-existent",
}) do
	if vim.fn.isdirectory(dir) == 1 then
		vim.opt.rtp:append(dir)
	end
end

if pcall(require, "askai") then
	require("askai").setup(common.askai)
end

if pcall(require, "gitsigns") then
	require("gitsigns").setup(common.gitsigns)
end

if pcall(require, "nvim-autopairs") then
	require("nvim-autopairs").setup(common.autopairs)
end

if pcall(require, "nvim-treesitter.config") then
	require("nvim-treesitter.config").setup(common.treesitter)
end

if pcall(require, "nvim-surround") then
	require("nvim-surround").setup(common.surround)
end

if pcall(require, "telescope") then
	common.telescope.setup()
end

if pcall(require, "non-existent") then
	require("non-existent").setup(common)
end
