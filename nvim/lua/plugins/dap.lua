return {
	"mfussenegger/nvim-dap",
	event = "VeryLazy",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"leoluz/nvim-dap-go",
		"mfussenegger/nvim-dap-python",
		"williamboman/mason.nvim",
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")
		dapui.setup()
		require("dap-go").setup()
		require("dap-python").setup()

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			vim.api.nvim_echo({
				{ "DAP terminated\n", "WarningMsg" },
				{ "\nPress any key to exit..." },
			}, true, {})
			vim.fn.getchar()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			vim.api.nvim_echo({
				{ "DAP exited\n", "WarningMsg" },
				{ "\nPress any key to exit..." },
			}, true, {})
			vim.fn.getchar()
			dapui.close()
		end

		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: toggle breakpoint" })
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "DAP: continue" })
		vim.keymap.set("n", "<leader>dd", dap.step_over, { desc = "DAP: step over" })
		vim.keymap.set("n", "<leader>ds", dap.step_into, { desc = "DAP: step into" })
	end,
}
