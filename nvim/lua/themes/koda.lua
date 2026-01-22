return {
	"oskarnurm/koda.nvim",
	config = function()
		require("koda").setup({
			transparent = vim.g.transparent_background,
		})
	end,
}
