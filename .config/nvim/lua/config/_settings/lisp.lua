local configure_rainbow = require('config.plugins.rainbow.theme')
local available, highlight = pcall(require, 'nvim-treesitter.highlight')
g.rainbow_active = 1
configure_rainbow()

-- Handle treesitter screweing up colored brackets
if available ~= nil then
    local hlmap = vim.treesitter.highlighter.hl_map
    hlmap.error = nil
    hlmap["punctuation.delimiter"] = "Delimiter"
    hlmap["punctuation.bracket"] = nil
end
