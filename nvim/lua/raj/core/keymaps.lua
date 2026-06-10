local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

-- Source current file instantly
vim.keymap.set("n", "<leader><leader>", function() vim.cmd("so") end)

-- Line manipulation in Visual Mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

-- Keep cursor stationary when appending lines or searching
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Continuous visual indentation
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Paste over selection without losing your yanked register
vim.keymap.set("x", "p", [["_dP]])

-- Delete directly into the black hole register (keeps your clipboard clean)
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Clear highlights and manage insert escapes
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clear search hl", silent = true })

-- PREVENT X DELETE FROM REGISTERING WHEN NEXT PASTE
vim.keymap.set("n", "x", '"_x', opts)

-- Global word substitution pattern under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word cursor is on globally" })

-- Change file permissions to executable dynamically
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true, desc = "makes file executable" })

-- ========================================================================
-- FIX: Built-in LSP Format relocated to Capital F to clear lowercase 'f'
-- ========================================================================
vim.keymap.set("n", "<leader>F", vim.lsp.buf.format, { desc = "Format Document (LSP)" })

-- ========================================================================
-- Navigation Namespace Extensions (Coexists perfectly with Snacks 'f' branch)
-- ========================================================================
-- Copy filepath to the clipboard
vim.keymap.set("n", "<leader>fp", function()
    local filePath = vim.fn.expand("%:~")
    vim.fn.setreg("+", filePath)
    print("File path copied to clipboard: " .. filePath)
end, { desc = "Copy file path to clipboard" })

-- ========================================================================
-- Native Tab Management Protocols
-- ========================================================================
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current file in new tab" })

-- ========================================================================
-- Window Split Layout Architecture
-- ========================================================================
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- ========================================================================
-- System Environment Restart Sequences
-- ========================================================================
vim.keymap.set("n", "<leader>re", "<cmd>restart<cr>", { desc = "Restart Neovim (:restart)" })

vim.keymap.set("n", "<leader>lr", function()
    vim.cmd("lsp restart")
    vim.notify("LSP restarted", vim.log.levels.INFO)
end, { desc = "Restart LSP Engine" })
