local utils = require('common.utils')
local M = {}

function M.setup()
    cmd [[packadd telescope.nvim]]

    local builtins = require('telescope.builtin')

    local options = {
        shorten_path = false,
        height = 10,
        layout_strategy = 'horizontal',
        layout_config = {
            preview_width = 0.65
        }
    }
    function _G.__telescope_current_buffer_fuzzy_find()
        builtins.current_buffer_fuzzy_find(options)
    end
    function _G.__telescope_files()
        builtins.find_files(options)
    end
    function _G.__telescope_treesitter()
        builtins.treesitter(options)
    end
    function _G.__telescope_buffers()
        builtins.buffers({
            sort_lastused = true,
            ignore_current_buffer = true,
            sorter = require('telescope.sorters').get_substr_matcher(),
            shorten_path = true,
            height = 10,
            layout_strategy = 'horizontal',
            layout_config = {
                preview_width = 0.65
            },
            show_all_buffers = true,
            color_devicons = true
        })
    end
    function _G.__telescope_grep()
        builtins.live_grep({
            shorten_path = false,
            height = 10,
            layout_strategy = 'horizontal',
            layout_config = {
                preview_width = 0.4
            }
        })
    end
    function _G.__telescope_commits()
        builtins.git_commits({
            height = 10,
            layout_strategy = 'horizontal',
            layout_config = {
                preview_width = 0.55
            }
        })
    end
    local opts = {
        silent = true,
        noremap = true
    }

    local leader_opts = {}

    utils.map_lua('n', '<leader>b', '__telescope_buffers()', leader_opts)
    utils.map_lua('n', '<C-f>', '__telescope_files()', opts)
    -- vim.api.nvim_set_keymap('n', '<Space>s',
    --                         "<cmd>lua require('telescope').extensions.frecency.frecency({layout_strategy = 'vertical'})<CR>",
    --    opts)
    -- utils.map_lua('n', '<leader>h', "require('telescope.builtin').help_tags(options)", opts)
    utils.map_lua('n', '<C-g>c', '__telescope_commits()', opts)
    utils.map_lua('n', '<leader>f', '__telescope_current_buffer_fuzzy_find()', leader_opts)
    utils.map_lua('n', '<C-t>', '__telescope_treesitter()', opts)
    utils.map_lua('n', '<leader>g', '__telescope_grep()', leader_opts)
    utils.map_lua('n', '<leader>pr', "require('telescope.builtin').pull_request()", leader_opts)

end

function M.config()
    local actions = require('telescope.actions')
    local sorters = require('telescope.sorters')
    local previewers = require('telescope.previewers')

    require'telescope'.setup {
        defaults = {
            prompt_prefix = ' 🔍 ',
            selection_caret = "ﰲ ",
            mappings = {
                i = {
                    ["<ESC>"] = actions.close,
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous
                },
                n = {
                    ["<ESC>"] = actions.close
                }
            },
            file_ignore_patterns = {"%.jpg", "%.jpeg", "%.png", "%.svg", "%.otf", "%.ttf"},
            file_sorter = sorters.get_fzy_sorter,
            generic_sorter = sorters.get_fzy_sorter,
            file_previewer = previewers.vim_buffer_cat.new,
            grep_previewer = previewers.vim_buffer_vimgrep.new,
            qflist_previewer = previewers.vim_buffer_qflist.new,
            layout_strategy = 'flex',
            winblend = 7,
            set_env = {
                COLORTERM = "truecolor"
            },
            color_devicons = true
        }
    }
end

return M
