return {
	"junegunn/vim-easy-align",
	branch = "master",
	lazy = false,
	config = function()
		vim.keymap.set("x", "ga", "<Plug>(EasyAlign)", { desc = "EasyAlign: execute easy align" })
		vim.keymap.set("n", "ga", "<Plug>(EasyAlign)", { desc = "EasyAlign: execute easy align" })
	end,
}
