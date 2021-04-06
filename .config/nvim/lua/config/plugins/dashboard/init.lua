local M = {}
function M.config()
    local home = os.getenv('HOME')

    g.dashboard_footer_icon = ' 🐬  '
    g.dashboard_default_executive = 'telescope'
    g.dashboard_session_directory = sessiondir

    -- g.dashboard_preview_command = 'figlet -f "3d" "Dashboard"'
    g.dashboard_preview_command = '/bin/cat'
    g.dashboard_preview_pipeline = 'lolcat'
    -- g.dashboard_preview_file = home .. '/.config/bbenzikry/resources/images/neovim.png'
    -- g.dashboard_preview_file = home .. '/neovim.sixel'
    g.dashboard_preview_file = home .. '/.config/nvim/static/neovim.cat'
    g.dashboard_preview_file_height = 10
    g.dashboard_preview_file_width = 300

    -- g.dashboard_custom_section = {
    --     a = {
    --         description = {'  Start / Load Session    '},
    --         command = 'Prosession .'
    --     },
    --     b = {
    --         description = {'  Recently Opened Files   '},
    --         command = 'Telescope oldfiles'
    --     },
    --     c = {
    --         description = {'  Find File               '},
    --         command = 'Telescope find_files find_command=rg,--hidden,--files'
    --     },
    --     e = {
    --         description = {'  Find Word               '},
    --         command = 'Telescope live_grep'
    --     }
    --     -- f = {
    --     --     description = {'  Marks                   '},
    --     --     command = 'Telescope marks'
    --     -- }
    -- }
    -- g.dashboard_custom_footer = {"[ ]"}

end

return M
