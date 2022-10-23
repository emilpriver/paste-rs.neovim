local function setup(parameters)
end


function publish_marked_code(input)
  print(input)
end

vim.api.nvim_create_user_command(
    'PublishPasteRS',
    function(input)
      publish_marked_code(input)
    end,
    {bang = true, desc = 'a new command to do the thing'}
)

return {
    setup = setup,
    local_lua_function = local_lua_function,
}
