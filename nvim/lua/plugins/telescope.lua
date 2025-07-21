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

		vim.keymap.set("n", "<leader>f", function()
			local word = vim.fn.expand("<cword>")
			builtin.live_grep({ default_text = word, layout_config = layout_config })
		end, { desc = "Telescope: live grep word under cursor", silent = true, noremap = true })

		vim.keymap.set("v", "<leader>f", function()
			local start_pos = vim.fn.getpos("'<")
			local end_pos = vim.fn.getpos("'>")
			local start_row = start_pos[2]
			local end_row = end_pos[2]

			local lines = vim.fn.getline(start_row, end_row)
			if #lines == 0 then
				return
			end
			lines[1] = string.sub(lines[1], start_pos[3], -1)
			builtin.live_grep({ default_text = lines[1] })
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
