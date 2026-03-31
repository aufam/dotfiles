return {
	"CopilotC-Nvim/CopilotChat.nvim",
	dependencies = {
		"github/copilot.vim",
		"nvim-lua/plenary.nvim",
	},
	build = "make tiktoken",
	config = function()
		-- vim.g.copilot_no_tab_map = true
		-- vim.keymap.set("i", "<C-l>", function()
		-- 	return vim.fn["copilot#Accept"]("")
		-- end, { expr = true, silent = true })

		require("CopilotChat").setup({
			model = "gpt-4.1", -- AI model to use
			temperature = 0.1, -- Lower = focused, higher = creative
			window = {
				layout = "float", -- 'vertical', 'horizontal', 'float'
				width = 0.75, -- 50% of screen width
				height = 0.75, -- 50% of screen width
				border = "rounded", -- 'single', 'double', 'rounded', 'solid'
			},
			auto_insert_mode = true, -- Enter insert mode when opening

			-- window = {
			-- 	layout = "float",
			-- 	width = 80, -- Fixed width in columns
			-- 	height = 20, -- Fixed height in rows
			-- 	border = "rounded", -- 'single', 'double', 'rounded', 'solid'
			-- 	title = "🤖 AI Assistant",
			-- 	zindex = 100, -- Ensure window stays on top
			-- },

			-- headers = {
			-- 	user = "👤 You",
			-- 	assistant = "🤖 Copilot",
			-- 	tool = "🔧 Tool",
			-- },

			separator = "━━",
			auto_fold = true, -- Automatically folds non-assistant messages
		})
	end,
}
