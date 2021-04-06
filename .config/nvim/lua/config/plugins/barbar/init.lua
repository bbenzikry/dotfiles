local M = {}
function M.config()
    g.bufferline = {
        animation = true,
        auto_hide = false,
        clickable = true,
        closable = true,

        -- Webdev icons
        icons = true,
        icon_separator_active = '▎',
        icon_separator_inactive = '▎',
        icon_close_tab = '',
        icon_close_tab_modified = '',

        maximum_padding = 1
    }
    utils.map('n', '<C-c>', '<cmd>BufferWipeout!<CR>', {
        silent = true
    })
    utils.map('n', '<Tab>', '<cmd>BufferNext<CR>', {
        silent = true
    })
    utils.map('n', '<s-Tab>', '<cmd>BufferPrevious<CR>', {
        silent = true
    })
end

return M
