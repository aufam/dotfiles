-- Visual Mode: Move selected lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

-- Visual Mode: Indent and reselect
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Normal Mode: Scrolling, search, and motion improvements
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines without moving cursor" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result centered and unfolded" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result centered and unfolded" })
vim.keymap.set("n", "=ap", "ma=ap'a", { desc = "Re-indent current paragraph" })

vim.keymap.set("n", "<leader><leader>", ":noh<CR>", { desc = "Clear search highlight", silent = true })
vim.keymap.set("n", "<leader>F", function()
	if vim.bo.fileencoding == "utf-8" then
		vim.cmd("%s/\\r//ge")
		vim.cmd("%s/\\s\\+$//e")
	end
end, { desc = "Trim trailing whitespace and \\r (UTF-8 only)", silent = true })

-- In normal mode, paste over selection without overwriting unnamed register
vim.keymap.set("n", "<leader>p", '"_dP', { desc = "Paste without overwriting register" })

-- System clipboard yanking and cutting
vim.keymap.set("n", "YY", '"+yy', { desc = "Yank line to system clipboard" })
vim.keymap.set("n", "XX", '"+dd', { desc = "Cut line to system clipboard" })

-- Visual mode paste (without overwriting default register)
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste (visual) without overwriting register" })

-- Yank to system clipboard (works in both normal and visual mode)
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })

-- Quick substitution using word under cursor
vim.keymap.set(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Substitute word under cursor" }
)

-- Buffer navigation
vim.keymap.set("n", "<S-Tab>", ":bp<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<Tab>", ":bn<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>c", ":bd<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>C", ":bd!<CR>", { desc = "Force close buffer" })
for i = 1, 9 do
	vim.keymap.set("n", "<leader>" .. i, ":buffer " .. i .. "<CR>", {
		desc = "Go to buffer " .. i,
	})
end
