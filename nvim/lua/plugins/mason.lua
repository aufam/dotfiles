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
				"zls",
				"buf_ls",
				"tombi",
				"yamlls",
				"html",
				"cssls",
				"dockerls",
				"docker_compose_language_service",
				"gitlab_ci_ls",
				"nginx_language_server",
			},
			automatic_installation = false,
		})

		require("mason-null-ls").setup({
			ensure_installed = {
				"stylua",
				"black",
				"shfmt",
			},
			automatic_installation = false,
		})

		require("mason-nvim-dap").setup({
			handlers = {},
			ensure_installed = {
				"codelldb",
				"delve",
			},
			automatic_installation = false,
		})
	end,
}
