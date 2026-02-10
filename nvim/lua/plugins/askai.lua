return {
	"aufam/askai.nvim",
	config = function()
		require("askai").setup({
			provider = "gemini", -- "gemini"|"openai"|"anthropic"
		})

		vim.keymap.set({ "n", "v" }, "<leader>ai", ":AskAI ", { desc = "askai: Ask AI about visual selections" })
	end,
}
