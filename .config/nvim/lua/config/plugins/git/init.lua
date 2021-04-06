local M = {}

function M.setup()
    vim.cmd [[packadd gitsigns.nvim]]
    require'gitsigns'.setup {
        signs = {
            add = {
                hl = 'DiffAdd',
                text = '+',
                numhl = 'GitSignsAddNr',
                show_count = true
            },
            change = {
                hl = 'DiffChange',
                text = '~',
                numhl = 'GitSignsChangeNr'
            },
            delete = {
                hl = 'DiffDelete',
                text = '-',
                show_count = true,
                numhl = 'GitSignsDeleteNr'
            },
            topdelete = {
                hl = 'DiffDelete',
                text = '‾',
                numhl = 'GitSignsDeleteNr'
            },
            changedelete = {
                hl = 'DiffChange',
                text = '~',
                numhl = 'GitSignsChangeNr'
            }
        },
        count_chars = {
            [1] = '',
            [2] = '₂',
            [3] = '₃',
            [4] = '₄',
            [5] = '₅',
            [6] = '₆',
            [7] = '₇',
            [8] = '₈',
            [9] = '₉',
            ['+'] = '₊'
        },
        numhl = false,
        linehl = false,
        keymaps = {
            -- Default keymap options
            noremap = true,
            buffer = true,

            ['n ]c'] = {
                expr = true,
                "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"
            },
            ['n [c'] = {
                expr = true,
                "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"
            },

            ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
            ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
            ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
            ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
            ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>'
        },
        watch_index = {
            interval = 1000
        },
        sign_priority = 5,
        use_decoration_api = true,
        status_formatter = nil, -- Use default,
        use_internal_diff = true
        -- current_line_blame = true
    }
end

return M
