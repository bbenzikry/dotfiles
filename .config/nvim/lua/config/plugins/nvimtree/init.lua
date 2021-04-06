local M = {}

function M.setup()
    cmd [[packadd nvim-web-devicons]]
    cmd [[packadd nvim-tree.lua]]

    o.termguicolors = true
    g.nvim_tree_ignore = {'.git', 'node_modules', '.cache', '.pytest_cache'}
    g.nvim_tree_auto_open = 0 -- 0 by default, opens the tree when typing `nvim $DIR` or `nvim`
    g.nvim_tree_auto_close = 1 -- 0 by default, closes the tree when it's the last window
    g.nvim_tree_follow = 1 -- 0 by default, this option allows the cursor to be updated when entering a buffer
    g.nvim_tree_indent_markers = 1 -- 0 by default, this option shows indent markers when folders are open
    g.nvim_tree_git_hl = 1 -- 0 by default, will enable file highlight for git attributes (can be used without the icons).
    g.nvim_tree_width = 30 -- 30 by default
    g.nvim_tree_quit_on_open = 0 -- 0 by default, closes the tree when you open a file
    g.nvim_tree_hide_dotfiles = 0 -- allow by default, this option hides files and folders starting with a dot `.`
    g.nvim_tree_tab_open = 1 -- 0 by default, will open the tree when entering a new tab and the tree was previously open
    g.nvim_tree_allow_resize = 1 -- 0 by default, will not resize the tree when opening a file
    g.nvim_tree_disable_keybindings = 0
    g.nvim_tree_side = "left"
    -- g.nvim_tree_root_folder_modifier = ":~"
    g.nvim_tree_root_folder_modifier = ":t:r"

    -- local get_lua_cb = function(cb_name)
    --     return string.format(":lua require'nvim-tree'.on_keypress('%s')<CR>", cb_name)
    -- end

    local get_lua_cb = require'nvim-tree.config'.nvim_tree_callback

    --  modify some of the key mappings
    g.nvim_tree_bindings = {
        ["<CR>"] = get_lua_cb("edit"),
        ["o"] = get_lua_cb("edit"),
        ["<2-LeftMouse>"] = get_lua_cb("edit"),
        ["<2-RightMouse>"] = get_lua_cb("cd"),
        ["<C-]>"] = get_lua_cb("cd"),
        ["<C-v>"] = get_lua_cb("vsplit"),
        ["<C-x>"] = get_lua_cb("split"),
        ["<C-t>"] = get_lua_cb("tabnew"),
        ["<BS>"] = get_lua_cb("close_node"),
        ["<S-CR>"] = get_lua_cb("close_node"),
        ["<Tab>"] = get_lua_cb("preview"),
        ["I"] = get_lua_cb("toggle_ignored"),
        ["H"] = get_lua_cb("toggle_dotfiles"),
        ["R"] = get_lua_cb("refresh"),
        ["a"] = get_lua_cb("create"),
        ["d"] = get_lua_cb("remove"),
        ["r"] = get_lua_cb("rename"),
        ["<C-r>"] = get_lua_cb("full_rename"),
        ["x"] = get_lua_cb("cut"),
        ["c"] = get_lua_cb("copy"),
        ["p"] = get_lua_cb("paste"),
        ["[c"] = get_lua_cb("prev_git_item"),
        ["]c"] = get_lua_cb("next_git_item"),
        ["-"] = get_lua_cb("dir_up"),
        ["q"] = get_lua_cb("close")
    }

    g.nvim_tree_show_icons = {
        git = 1,
        folders = 1,
        files = 1
    }

    g.nvim_tree_icons = {
        default = " ",
        symlink = " ",
        git = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★"
        },
        folder = {
            default = "",
            open = "",
            symlink = ""
        }
    }

    utils.map_lua('n', '<C-n>', "require 'nvim-tree'.toggle()")
    utils.map('n', '<C-z>', '<cmd>NvimTreeFindFile<CR>', {
        silent = true
    })
end

return M
