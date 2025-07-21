return {
	"rcarriga/nvim-notify",
	config = function()
		require("notify").setup({
			background_colour = "#000000",
			render = "minimal",
			stages = "static",
		})

		vim.notify = require("notify")
	end,
}
