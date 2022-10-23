local function setup(parameters)
end

function global_lua_function()
    print "paste-rs.paste-rs.init global_lua_function: hello"
end

local function unexported_local_function()
    print "paste-rs.paste-rs.init unexported_local_function: hello"
end

local function local_lua_function()
    print "paste-rs.paste-rs.init local_lua_function: hello"
end

vim.api.nvim_create_user_command(
    'PublishPasteRS',
    function(input)
      publish.Publish_marked_code(input)
    end,
    {bang = true, desc = 'a new command to do the thing'}
)

return {
    setup = setup,
    local_lua_function = local_lua_function,
}
