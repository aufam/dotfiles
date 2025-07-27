return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "" }, -- unstaged add
				change = { text = "" }, -- unstaged change
				delete = { text = "" }, -- unstaged delete
				topdelete = { text = "󰐊" },
				changedelete = { text = "󰍴" },
				untracked = { text = "" },
			},
			signs_staged = {
				add = { text = "" }, -- staged add (check-square)
				change = { text = "" }, -- staged change (note)
				delete = { text = "" }, -- staged delete (minus-square)
				topdelete = { text = "󰘚" }, -- staged top delete
				changedelete = { text = "󱗜" }, -- staged change + delete
			},
		})
		vim.keymap.set("n", "<leader>gn", ":Gitsigns next_hunk<CR>", { desc = "Gitsigns: Go to next Git hunk" })
		vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Gitsigns: Preview Git hunk" })
		vim.keymap.set("n", "<leader>gu", ":Gitsigns undo_stage_hunk<CR>", { desc = "Gitsigns: Undo stage hunk" })
		vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "Gitsigns: Reset Git hunk" })
		vim.keymap.set("n", "<leader>gR", ":Gitsigns reset_buffer<CR>", { desc = "Gitsigns: Reset Git buffer" })
		vim.keymap.set("n", "<leader>gd", ":Gitsigns diffthis<CR>", { desc = "Gitsigns: Diff with index" })
		vim.keymap.set("n", "<leader>gD", ":Gitsigns toggle_deleted<CR>", { desc = "Gitsigns: Toggle deleted lines" })
		vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>", { desc = "Gitsigns: Show blame of this line" })
	end,
}
