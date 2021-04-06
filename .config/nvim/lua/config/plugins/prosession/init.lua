local M = {}
function M.config()
    g.prosession_on_startup = 0 -- Autoload sessions
    g.prosession_per_branch = 1 -- Sessions per Git branch
    g.prosession_dir = sessiondir

    utils.map('n', '<Leader>se', '<cmd>Prosession .<CR>', {
        silent = true
    })
    cmd ':ab Pro Prosession .'
    cmd ':ab pro Prosession .'
end

return M
