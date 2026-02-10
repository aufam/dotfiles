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

local enable_formatter = function(augroup, client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({
			group = augroup,
			buffer = bufnr,
		})
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({
					bufnr = bufnr,
				})
			end,
		})
	end
end

local get_python_path = function(root_dir)
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

local function get_compile_commands_dir()
	local root_dir = vim.fn.getcwd()

	if vim.fn.filereadable(root_dir .. "/compile_commands.json") == 1 then
		return root_dir
	elseif
		vim.fn.isdirectory(root_dir .. "/build") == 1
		and vim.fn.filereadable(root_dir .. "/build/compile_commands.json") == 1
	then
		return root_dir .. "/build"
	elseif
		vim.fn.isdirectory(root_dir .. "/debug") == 1
		and vim.fn.filereadable(root_dir .. "/debug/compile_commands.json") == 1
	then
		return root_dir .. "/debug"
	elseif
		vim.fn.isdirectory(root_dir .. "/release") == 1
		and vim.fn.filereadable(root_dir .. "/release/compile_commands.json") == 1
	then
		return root_dir .. "/release"
	else
		return root_dir -- fallback to root even if no compile_commands.json
	end
end

local settings = {
	Lua = {
		diagnostics = { globals = { "vim" } },
		workspace = { library = vim.api.nvim_get_runtime_file("", true) },
	},
	python = {
		pythonPath = get_python_path(vim.fn.getcwd()),
		analysis = {
			autoSearchPaths = true,
			useLibraryCodeForTypes = true,
			diagnosticMode = "openFilesOnly",
		},
	},
	zls = {
		enable_autofix = true,
		enable_inlay_hints = true,
		warn_style = true,
	},
}

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"SmiteshP/nvim-navic",
	},
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		-- cpp
		vim.lsp.config("clangd", {
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
		})

		-- lsp only
		for _, server in ipairs({ "lua_ls", "gopls", "cmake", "pyright", "tombi" }) do
			vim.lsp.config(server, { on_attach = on_attach, capabilities = capabilities, settings = settings })
		end

		-- lsp + formatter
		for _, server in ipairs({ "rust_analyzer", "zls", "buf_ls" }) do
			vim.lsp.config(server, {
				on_attach = function(client, bufnr)
					enable_formatter(augroup, client, bufnr)
					on_attach(client, bufnr)
				end,
				capabilities = capabilities,
				settings = settings,
			})
		end

		-- enable all
		for _, server in ipairs({
			-- cpp
			"clangd",
			-- lsp only
			"lua_ls",
			"gopls",
			"cmake",
			"pyright",
			"tombi",
			-- lsp + formatter
			"rust_analyzer",
			"zls",
			"buf_ls",
		}) do
			vim.lsp.enable(server)
		end
	end,
}
