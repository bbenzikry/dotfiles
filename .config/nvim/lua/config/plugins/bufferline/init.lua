vim.o.termguicolors = true

-- colors for active , inactive buffer tabs 
require"bufferline".setup {
    options = {
        buffer_close_icon = "",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 18,
        max_prefix_length = 15,
        tab_size = 18,
        enforce_regular_tabs = true,
        view = "multiwindow",
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        -- separator_style = "slant" | "thick" | "thin" | { 'any', 'any' },
        separator_style = "thin",
        diagnostics = "nvim_lsp"
    }
}

local opt = {
    silent = true
}

-- tabnew and tabprev
vim.api.nvim_set_keymap("n", "<Leader>tn", [[<Cmd>BufferLineCycleNext<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>tp", [[<Cmd>BufferLineCyclePrev<CR>]], opt)
