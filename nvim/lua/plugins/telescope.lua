return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local builtin = require("telescope.builtin")
		local layout_config = { preview_width = 0.5 }

		vim.keymap.set("n", "<leader>e", function()
			builtin.find_files({ layout_config = layout_config })
		end, { desc = "Telescope: find files" })

		vim.keymap.set("n", "<leader>F", function()
			builtin.live_grep({ layout_config = layout_config })
		end, { desc = "Telescope: live grep word under cursor", silent = true, noremap = true })

		vim.keymap.set({ "n", "v" }, "<leader>f", function()
			builtin.grep_string({ layout_config = layout_config })
		end, { desc = "Telescope: live grep word under cursor", silent = true, noremap = true })

		vim.keymap.set("n", "<leader>b", function()
			builtin.buffers({ layout_config = layout_config })
		end, { desc = "Telescope: show buffers" })

		vim.keymap.set("n", "<leader>gf", function()
			builtin.git_files({
				layout_config = layout_config,
				git_command = { "git", "ls-files", "--modified", "--other", "--exclude-standard" },
			})
		end, { desc = "Telescope: show modified files" })
	end,
}
