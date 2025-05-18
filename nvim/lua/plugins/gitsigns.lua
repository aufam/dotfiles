return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "-" },
				topdelete = { text = "‾" },
				changedelete = { text = "*" },
				untracked = { text = "?" },
			},
		})
		vim.keymap.set("n", "<leader>gn", ":Gitsigns next_hunk<CR>", { desc = "Go to next Git hunk" })
		vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Preview Git hunk" })
		vim.keymap.set("n", "<leader>gu", ":Gitsigns undo_stage_hunk<CR>", { desc = "Undo stage hunk" })
		vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "Reset Git hunk" })
		vim.keymap.set("n", "<leader>gR", ":Gitsigns reset_buffer<CR>", { desc = "Reset Git buffer" })
		vim.keymap.set("n", "<leader>gd", ":Gitsigns diffthis<CR>", { desc = "Diff with index" })
		vim.keymap.set("n", "<leader>gD", ":Gitsigns toggle_deleted<CR>", { desc = "Toggle deleted lines" })
	end,
}
