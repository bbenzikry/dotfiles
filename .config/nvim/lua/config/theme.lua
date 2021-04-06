local opt = utils.opt
local map = utils.map
local has_colorbuddy = pcall(require, 'colorbuddy')
local configure_rainbow = require('config.plugins.rainbow.theme')
g.snazzybuddy_icons = true
-- TODO: make sure initial load fits the current iterm profile. 
g.background = 'dark'
configure_rainbow()
if has_colorbuddy then
    require('colorbuddy').colorscheme('snazzybuddy')
end
function ThemeToggle()
    if vim.g.background == 'dark' then
        vim.g.background = 'light'
    else
        vim.g.background = 'dark'
    end
    if vim.g.background ~= nil then
        -- Change iterm profile to dark / light appropriateley
        -- The iterm python API is a bit slow :( so the transition is not as smooth as I want it to be.
        -- iterm-profile-py is in ~/exec/bin
        vim.cmd([[:silent exec "!iterm-profile-py ]] .. vim.g.background .. '"')
    end
    if has_colorbuddy then
        require('snazzybuddy').reload()
    end
    configure_rainbow()
end
map('n', '<leader>1', ':lua ThemeToggle()<cr>', {
    silent = true
})
function SetTheme(color)
    vim.g.background = color
end
