return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>e", builtin.find_files, {})
        vim.keymap.set("n", "<leader>f", builtin.live_grep, {})
        vim.keymap.set("n", "<leader>gf", builtin.git_files, {})
    end,
}
