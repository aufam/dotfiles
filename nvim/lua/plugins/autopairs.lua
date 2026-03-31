local common = require("config.common")

return {
	"windwp/nvim-autopairs",
	branch = "master",
	event = "InsertEnter",
	config = function()
		require("nvim-autopairs").setup(common.autopairs)
	end,
}
