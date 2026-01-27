return {
	"junegunn/vim-easy-align",
	branch = "master",
	lazy = false,
	config = function()
		vim.keymap.set("v", "ga", "<Plug>(EasyAlign)", { desc = "EasyAlign: execute easy align" })
	end,
}
