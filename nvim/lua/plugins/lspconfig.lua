local on_attach = function(client, bufnr)
	if client.server_capabilities.documentSymbolProvider then
		require("nvim-navic").attach(client, bufnr)
	end
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP: Hover documentation" })
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP: Go to definition" })
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "LSP: Go to declaration" })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "LSP: Go to implementation" })
	vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "LSP: Find references" })
	vim.keymap.set("n", "<leader>?", vim.diagnostic.open_float, { buffer = bufnr, desc = "LSP: Show diagnostics" })
	vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, { buffer = bufnr, desc = "LSP: Code action" })
	vim.keymap.set("n", "<leader>r", vim.lsp.buf.format, { buffer = bufnr, desc = "LSP: Format file", silent = true })
end

return {
	"neovim/nvim-lspconfig",
    dependencies = {
        "SmiteshP/nvim-navic"
    },
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local lspconfig = require("lspconfig")

		-- lua
		lspconfig.lua_ls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					workspace = { library = vim.api.nvim_get_runtime_file("", true) },
				},
			},
		})

		-- cpp
		local function get_compile_commands_dir()
			local root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git")(vim.fn.getcwd())
				or vim.fn.getcwd()

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
			on_attach = on_attach,
			capabilities = capabilities,
			filetypes = { "c", "cpp", "cc", "cxx" },
			cmd = {
				"clangd",
				"--header-insertion=never",
				"--header-insertion-decorators=false",
				"--clang-tidy=true",
				"--background-index=true",
				"--pch-storage=memory",
				"--completion-style=detailed",
				"--j=2",
				"--compile-commands-dir=" .. get_compile_commands_dir(),
			},
			root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git", "compile_flags.txt"),
		})

		lspconfig.pyright.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			on_new_config = function(new_config, new_root_dir)
				local function get_python_path(root_dir)
					local paths = {
						root_dir .. "/venv/bin/python",
						root_dir .. "/.venv/bin/python",
						root_dir .. "/env/bin/python",
						root_dir .. "/.env/bin/python",
						root_dir .. "/venv/Scripts/python.exe", -- Windows
						root_dir .. "/.venv/Scripts/python.exe", -- Windows
						root_dir .. "/env/Scripts/python.exe", -- Windows
						root_dir .. "/.env/Scripts/python.exe", -- Windows
					}
					for _, path in ipairs(paths) do
						if vim.fn.executable(path) == 1 then
							return path
						end
					end
					return nil
				end

				local python_path = get_python_path(new_root_dir)
				if python_path then
					new_config.settings = vim.tbl_deep_extend("force", new_config.settings or {}, {
						python = {
							pythonPath = python_path,
						},
					})
				end
			end,
		})

		lspconfig.rust_analyzer.setup({ on_attach = on_attach, capabilities = capabilities })
		lspconfig.gopls.setup({ on_attach = on_attach, capabilities = capabilities })
		lspconfig.zls.setup({ on_attach = on_attach, capabilities = capabilities })
		lspconfig.cmake.setup({ on_attach = on_attach, capabilities = capabilities })
		lspconfig.buf_ls.setup({ on_attach = on_attach, capabilities = capabilities })
	end,
}
