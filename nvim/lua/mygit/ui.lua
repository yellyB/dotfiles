-- ~/.config/nvim/lua/mygit/ui.lua

local M = {}

M.setup = function()
  vim.api.nvim_create_user_command("MyGitUI", function()
    print("My Git UI 작동 테스트 성공!")
  end, {})
end

return M
