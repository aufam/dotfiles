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
			capabilities = capabilities,
			filetypes = { "c", "cpp", "cc", "cxx" },
			cmd = {
				"clangd-19",
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

		lspconfig.rust_analyzer.setup({ capabilities = capabilities })
		lspconfig.gopls.setup({ capabilities = capabilities })
		lspconfig.zls.setup({ capabilities = capabilities })

		lspconfig.cmake.setup({ capabilities = capabilities })
		lspconfig.buf_ls.setup({ capabilities = capabilities })
	end,
}
