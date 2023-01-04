local utils = require "utils"

local k = vim.keymap


-- k.set("n", "<ESC>", "<cmd> noh <CR>")
k.set("n", "<ESC>", function()
  local ft = {
    ["guihua"] = true,
  }
  if ft[vim.o.ft] then
    utils.close_current_win(true)
  else
    vim.cmd "noh"
  end
end)
k.set("n", "<C-h>", "<C-w>h")
k.set("n", "<C-l>", "<C-w>l")
k.set("n", "<C-j>", "<C-w>j")
k.set("n", "<C-k>", "<C-w>k")

k.set("n", "<C-n>", "<cmd> NvimTreeToggle <CR>")
k.set("n", "<leader>n", "<cmd> NvimTreeToggle <CR>")
k.set("n", "<leader>w", function() require('nvim-window').pick() end)
k.set("n", "<leader>b", "<cmd> Telescope buffers <CR>")
k.set("n", "<leader>fw", "<cmd> Telescope live_grep <CR>")
k.set("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>")
k.set("n", "<leader>ff", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>")
k.set("n", "<leader>/", function() require("Comment.api").toggle.linewise.current() end)
k.set("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
