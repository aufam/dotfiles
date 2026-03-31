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

vim.keymap.set("n", "<leader><leader>", function()
	if vim.bo.fileencoding == "utf-8" then
		vim.cmd("keeppatterns %s/\\r//ge")
		vim.cmd("keeppatterns %s/\\s\\+$//e")
	end
	vim.cmd([[keeppatterns %s/\%x80..//ge]])
	vim.cmd("noh")
end, { desc = "Trim whitspace clear <80> symbols and clear search highlight", silent = true })

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
	vim.keymap.set("n", "<leader>" .. i, function()
		local ls_output = vim.fn.execute("ls")

		local lines = vim.split(ls_output, "\n")
		local line = lines[i + 1]
		if line == nil then
			print("Buffer " .. i .. " not found.")
			return
		end

		local bufnr_str, _ = line:match("^%s*(%d+)%s+(.-)$")
		local bufnr = tonumber(bufnr_str)
		vim.cmd("buffer " .. bufnr)
	end, { desc = "Go to buffer " .. i })
end

-- Convert this buffer into quickfix list
vim.keymap.set("n", "<leader>q", function()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local items = {}

	for _, line in ipairs(lines) do
		local filename = string.match(line, "^[^:]*")
		local lnum = tonumber(string.match(line, "^[^:]*:(%d+)"))
		local col = tonumber(string.match(line, "^[^:]*:%d+:(%d+)"))
		local text = string.match(line, "^[^:]*:%d+:%d+: (.*)")

		if filename and vim.fn.filereadable(filename) == 1 then
			-- Valid file: add as navigable quickfix entry
			table.insert(items, {
				filename = filename,
				lnum = lnum or 0,
				col = col or 0,
				text = text or line,
			})
		else
			-- No file found: just plain text entry
			table.insert(items, { text = line })
		end
	end

	vim.fn.setqflist(items)
	vim.cmd("copen")
end, { desc = "Parse current buffer into quickfix (check file existence)" })

-- Macro
vim.keymap.set("n", "<leader>Q", "@q", { desc = "apply q macro" })

-- Completion
vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }
vim.opt.complete = { ".", "w", "b", "u", "t", "i" }

vim.keymap.set("i", "<C-Space>", "<C-x><C-o>", { silent = true })
vim.keymap.set("i", "<C-b>", "<C-x><C-n>", { silent = true })
vim.keymap.set("i", "<C-f>", "<C-x><C-f>", { silent = true })

vim.keymap.set("i", "<Down>", function()
	if vim.fn.pumvisible() == 1 then
		return "<C-n>"
	else
		return "<Down>"
	end
end, { expr = true, silent = true })

vim.keymap.set("i", "<Up>", function()
	if vim.fn.pumvisible() == 1 then
		return "<C-p>"
	else
		return "<Up>"
	end
end, { expr = true, silent = true })

vim.keymap.set("i", "<CR>", function()
	if vim.fn.pumvisible() == 1 then
		return "<C-y>"
	else
		return "<CR>"
	end
end, { expr = true, silent = true })
