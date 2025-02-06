local function toggle_bool()
  local word = vim.fn.expand("<cword>")
  local toggle_word

  if word == "true" then
    toggle_word = "false"
  elseif word == "True" then
    toggle_word = "False"
  elseif word == "false" then
    toggle_word = "true"
  elseif word == "False" then
    toggle_word = "True"
  else
    return
  end

  local line = vim.fn.getline('.')
  local new_line = string.gsub(line, word, toggle_word)
  vim.fn.setline('.', new_line)
end

vim.api.nvim_create_user_command("ToggleBool", toggle_bool, {})
