local customKeymap = function(mode, lhs, rhs, description)
  local opts = { noremap = true, silent = true }
  local customOpts = {}
  for k, v in pairs(opts) do
    customOpts[k] = v
  end
  if description then
    customOpts.desc = description
  end
  vim.keymap.set(mode, lhs, rhs, customOpts)
end

return customKeymap
