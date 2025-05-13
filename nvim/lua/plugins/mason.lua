return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"jay-babu/mason-null-ls.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		require("mason").setup({})

		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
			},
			automatic_installation = true,
		})

		require("mason-null-ls").setup({
			ensure_installed = {
				"stylua",
			},
			automatic_installation = true,
		})

		require("mason-nvim-dap").setup({
			ensure_installed = {
				"codelldb",
				"delve",
				"python",
			},
			automatic_installation = true,
		})
	end,
}
