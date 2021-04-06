local t = utils.t
local M = {}

function M.config()
    vim.cmd [[packadd nvim-compe]]
    require"compe".setup {
        enabled = true,
        autocomplete = true,
        debug = false,
        min_length = 2,
        preselect = 'disabled',
        -- preselect = 'enable',
        throttle_time = 80,
        source_timeout = 200,
        incomplete_delay = 400,
        -- max_abbr_width = 100,
        -- max_kind_width = 100,
        -- max_menu_width = 100,
        documentation = true,
        source = {
            vim_dadbod_completion = true,
            nvim_lsp = true,
            path = true,
            buffer = {
                kind = " Buffer",
                priority = 3
            },
            calc = true,
            vsnip = {
                kind = " Snippet",
                priority = 2
            },
            tabnine = {
                max_num_results = 3,
                priority = 3,
                max_line = 1000,
                show_prediction_strength = true
            },
            nvim_lua = true,
            spell = true,
            tags = true,
            snippets_nvim = true,
            treesitter = true
            -- omni = true
        }
        -- source = {
        --     path = {menu = '[PATH]', priority = 9},
        --     treesitter = {menu = '[TS]', priority = 9},
        --     vsnip = true,
        --     buffer = {menu = '[BUF]', priority = 8},
        --     nvim_lsp = {menu = '[LSP]', priority = 10, sort = false},
        --     nvim_lua = {menu = '[LUA]', priority = 8},
        --     snippets_nvim = {menu = '[SNP]', priority = 10},
        --     spell = true,
        --     calc = true,
        --     tags = true
        -- }
    }

    local check_back_space = function()
        local col = vim.fn.col('.') - 1
        if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
            return true
        else
            return false
        end
    end

    -- Use (s-)tab to:
    --- move to prev/next item in completion menuone
    --- jump to prev/next snippet's placeholder
    _G.tab_complete = function()
        if vim.fn.pumvisible() == 1 then
            return t "<C-n>"
        elseif vim.fn.call("vsnip#available", {1}) == 1 then
            return t "<Plug>(vsnip-expand-or-jump)"
        elseif check_back_space() then
            return t "<Tab>"
        else
            return vim.fn['compe#complete']()
        end
    end

    _G.s_tab_complete = function()
        if vim.fn.pumvisible() == 1 then
            return t "<C-p>"
        elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
            return t "<Plug>(vsnip-jump-prev)"
        else
            return t "<S-Tab>"
        end
    end

    function _G.completions()
        local npairs = require("nvim-autopairs")
        if vim.fn.pumvisible() == 1 then
            if vim.fn.complete_info()["selected"] ~= -1 then
                -- return vim.fn["compe#confirm"]("<CR>")
                return vim.fn["compe#confirm"]()
            end
        end
        return npairs.check_break_line_char()
    end

    -- function _G.completions()
    --     local npairs = require("nvim-autopairs")
    --     if vim.fn.pumvisible() ~= 0 then

    --         if vim.fn.complete_info()["selected"] ~= -1 then
    --             return vim.fn["compe#confirm"]()
    --         end

    --         vim.fn.nvim_select_popupmenu_item(0, false, false, {})
    --         return vim.fn["compe#confirm"]()
    --     end

    --     return npairs.check_break_line_char()
    -- end

    --  mappings

    vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {
        expr = true
    })
    vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {
        expr = true
    })
    vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {
        expr = true
    })
    vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {
        expr = true
    })

    utils.map('i', '<C-Space>', 'compe#complete()', {
        noremap = true,
        silent = true,
        expr = true
    })

    vim.api.nvim_set_keymap("i", t "<CR>", "v:lua.completions()", {
        expr = true
    })
    -- vim.api.nvim_set_keymap('i', t '<CR>', [[compe#confirm('<CR>')]], {
    --     expr = true
    -- })

    vim.api.nvim_set_keymap("i", t "<C-D>", "compe#scroll({ 'delta': +4 })", {
        silent = true,
        expr = true,
        noremap = true
    })
    vim.api.nvim_set_keymap("i", t "<C-B>", "compe#scroll({ 'delta': -4 })", {
        silent = true,
        expr = true,
        noremap = true
    })
end

return M
