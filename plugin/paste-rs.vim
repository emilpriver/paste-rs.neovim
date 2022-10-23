
" The VimL/VimScript code is included in this file to demonstrate that the
" file is being loaded. It is not required for the Lua code to execute and can
" be deleted.

echo "paste-rs.vim: VimL code executing."

function LuaDoItVimL()
    echo "paste-rs.vim LuaDoItVimL(): hello"
endfunction

" Neovim knows about finding VimL files in the `plugin` directory, but it
" won't find Lua files in the same location. So, you need to bootstrap your
" Lua code using a VimL file. There are two possibilities:

" 1. Lua code can be embedded in a VimL file by using a lua block.
lua <<EOF
    function lua_do_it_lua()
        print("paste-rs.vim lua_do_it_lua(): hello")
    end

    print "paste-rs.vim: Lua code executing."
EOF

" 2. Lua code can be built in a pure Lua file and imported as a module from
" the VimL file. `paste-rs` is a directory in the `lua` folder. Because
" only the `paste-rs` directory is specified, Neovim will look for a
" `lua.lua` file, then an `init.lua` file in that directory. In this case, it
" will find the `lua\paste-rs\init.lua` file.
lua paste-rs = require("myluamodule")

" Common convention in the Neovim plugin community is to require the module
" and use it all at once:
lua require'paste-rs'.setup({p1 = "value1"})



" Once the `require` statement completes, the `global_lua_function` Lua
" function defined in `lua\paste-rs\init.lua` will be available without
" qualification.
lua global_lua_function()

" Once the `require` statement completes, the `local_lua_function` Lua
" function defined in `lua\paste-rs\init.lua` will be available when
" qualified with the module name.
lua paste-rs.local_lua_function()

" A Lua function can be mapped to a key. Here, Alt-Ctrl-G will echo a message.
" This is a mapping to the function that wasn't carefully scoped in the Lua
" file. Since this function was exported globally, that symbol is available
" everywhere, once the module has been loaded. (See the `require` statement
" above.)
"
" NOTE: There is now (starting with Neovim 7) a pure Lua option to replace this key mapping.
"
" vim.keymap.set('n', 'M-C-G', function()
"   print('Hello')
" end, {desc = 'Say hello key mapping.', remap = false})
"
nmap <M-C-G> :lua global_lua_function()<CR>

" A local Lua function can be mapped to a key, if it was exported from the
" module. Here, Alt-Ctrl-L will echo a message.  This is a mapping to the
" function that was qualified with `local`, so it is only available outside
" the module when qualified with the module name.  (See the `require`
" statement above.)
"
" NOTE: There is now (starting with Neovim 7) a pure Lua option to replace this key mapping.
"
" vim.keymap.set('n', 'M-C-G', function()
"   print('Hello')
" end, {desc = 'Say hello key mapping.', remap = false})
"
nmap <M-C-L> :lua paste-rs.local_lua_function()<CR>

" A key mapping can be configured that uses the require statement directly,
" so a module doesn't need to be defined in the local scope.
"
" NOTE: There is now (starting with Neovim 7) a pure Lua option to replace this key mapping.
"
" vim.keymap.set('n', 'M-C-G', function()
"   print('Hello')
" end, {desc = 'Say hello key mapping.', remap = false})
"
nmap <M-C-L> :lua require'paste-rs'.local_lua_function()<CR>

