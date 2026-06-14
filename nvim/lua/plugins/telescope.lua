local common = require("config.common")

return {
	"nvim-telescope/telescope.nvim",
	branch = "master",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = common.telescope.setup,
}
