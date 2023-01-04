local M = {}

M.close_current_win = function(force)
  vim.api.nvim_win_close(0, force)
end

return M
