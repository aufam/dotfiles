return {
	"aufam/askai.nvim",
	config = function()
		require("askai").setup({
			provider = "gemini", -- gemini or openai
		})

		vim.keymap.set("v", "<leader>ai", ":AskAI ", { desc = "askai: Ask AI about visual selections" })
	end,
}
