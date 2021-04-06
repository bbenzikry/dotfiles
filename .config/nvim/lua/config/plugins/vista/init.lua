local M = {}
local map = utils.map
local opt = {
    noremap = true,
    silent = true
}

function M.setup()
    g.vista_default_executive = 'nvim_lsp'
    g.vista_echo_cursor_strategy = 'floating_win'
end

function M.config()
    map('n', '<Leader>vd', '<cmd>Vista finder fzf:nvim_lsp<CR>', opt)
end

return M
