return {
	"windwp/nvim-autopairs",
	branch = "master",
	event = "InsertEnter",
	config = function()
		require("nvim-autopairs").setup({
			check_ts = true,
		})
	end,
}
