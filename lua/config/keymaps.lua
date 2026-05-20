-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

local opt = vim.opt
opt.tabstop = 4 -- A TAB character will appear as 4 spaces wide
opt.shiftwidth = 4 -- Indent operations (like >> or gg=G) use a width of 4
opt.expandtab = false -- Pressing TAB inserts a TAB character, not spaces
opt.softtabstop = 0 -- Set to 0 so tab and backspace always use a real tab character if possible
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
-- Leader key

-- <leader>pv  (Space + p + v)
-- Open file explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Visual mode J
-- Move selected lines DOWN
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- Visual mode K
-- Move selected lines UP
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- J
-- Join lines but keep cursor position
vim.keymap.set("n", "J", "mzJ`z")

-- Ctrl+d
-- Scroll half page down and center cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- Ctrl+u
-- Scroll half page up and center cursor
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- n
-- Next search result centered
vim.keymap.set("n", "n", "nzzzv")

-- N
-- Previous search result centered
vim.keymap.set("n", "N", "Nzzzv")

-- <leader>y  (Space + y)
-- Copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

-- <leader>Y  (Space + Shift + y)
-- Copy full line to system clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- <leader>d  (Space + d)
-- Delete without affecting clipboard
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

-- Visual mode <leader>p  (Space + p)
-- Paste without overwriting clipboard
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Ctrl+c (insert mode)
-- Escape insert mode
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Disable Ex mode (accidental press)
vim.keymap.set("n", "Q", "<nop>")

-- Ctrl+k
-- Next quickfix item (compiler errors, grep results)
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")

-- Ctrl+j
-- Previous quickfix item
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")

-- <leader>s  (Space + s)
-- Replace word under cursor across the file
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- <leader>x  (Space + x)
-- Make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
-- Ctrl + q
-- Attempt to quit Neovim. If there are unsaved changes, Vim will ask what to do.
vim.keymap.set("n", "<C-q>", ":confirm qa<CR>")
-- Run current file
vim.keymap.set("n", "<leader>rr", function()
	vim.cmd("w")
	local file = vim.fn.expand("%")
	local ext = vim.fn.expand("%:e")

	if ext == "cpp" or ext == "cc" or ext == "c" then
		local out = vim.fn.tempname()
		vim.cmd("split | terminal g++ -std=c++17 " .. file .. " -o " .. out .. " && " .. out)
	elseif ext == "py" then
		vim.cmd("split | terminal python3 " .. file)
	elseif ext == "lua" then
		vim.cmd("split | terminal lua " .. file)
	end
end, { desc = "Run file" })
-- Quick fix for common DSA needs
vim.keymap.set("n", "<leader>ct", function()
	local template = {
		"#include <iostream>",
		"using namespace std;",
		"",
		"int main() {",
		"    ios_base::sync_with_stdio(false);",
		"    cin.tie(NULL);",
		"    ",
		"    ",
		"    return 0;",
		"}",
	}
	vim.api.nvim_buf_set_lines(0, 0, -1, false, template)
	-- vim.api.nvim_win_set_cursor(0, { 8, 4 })
end, { desc = "DSA template" })
vim.api.nvim_set_hl(0, "Cursor", { fg = "black", bg = "yellow" })
