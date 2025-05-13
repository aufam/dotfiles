return {
	"neovim/nvim-lspconfig",
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local lspconfig = require("lspconfig")

		-- lua
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					workspace = { library = vim.api.nvim_get_runtime_file("", true) },
				},
			},
		})

		-- cpp
		local util = require("lspconfig.util")

		local function get_compile_commands_dir()
			local root_dir = util.root_pattern("compile_commands.json", ".git")(vim.fn.getcwd()) or vim.fn.getcwd()

			if vim.fn.filereadable(root_dir .. "/compile_commands.json") == 1 then
				return root_dir
			elseif
				vim.fn.isdirectory(root_dir .. "/build") == 1
				and vim.fn.filereadable(root_dir .. "/build/compile_commands.json") == 1
			then
				return root_dir .. "/build"
			else
				return root_dir -- fallback to root even if no compile_commands.json
			end
		end

		lspconfig.clangd.setup({
			cmd = { "clangd", "--clang-tidy", "--compile-commands-dir=" .. get_compile_commands_dir() },
			root_dir = util.root_pattern("compile_commands.json", ".git", "compile_flags.txt"),
		})

		lspconfig.cmake.setup({ capabilities = capabilities })
		lspconfig.pyright.setup({ capabilities = capabilities })
		lspconfig.rust_analyzer.setup({ capabilities = capabilities })
		lspconfig.gopls.setup({ capabilities = capabilities })
		lspconfig.zls.setup({ capabilities = capabilities })
	end,
}
