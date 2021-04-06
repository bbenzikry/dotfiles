local M = {}
function M.config()
    -- g.indent_blankline_char = '|'
    g.indent_blankline_use_treesitter = true
    g.indent_blankline_show_current_context = true
    g.indent_blankline_space_char_highlight_list = 'IndentLine'
    g.indent_blankline_show_first_indent_level = false

    g.indent_blankline_buftype_exclude = {'terminal'}
    g.indent_blankline_filetype_exclude = {'NvimTree', 'help', 'startify', 'dashboard', 'packer'}
    local indent_colors = {}
    for i = 1, 7 do
        table.insert(indent_colors, 'SnazzyIndent' .. i)
    end

    g.indent_blankline_char_highlight_list = indent_colors
    -- g.indent_blankline_show_trailing_blankline_indent = false
end

return M
