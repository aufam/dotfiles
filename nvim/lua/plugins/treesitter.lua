local common = require("config.common")

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup(common.treesitter)
	end,
}
