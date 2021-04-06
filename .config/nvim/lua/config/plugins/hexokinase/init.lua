local M = {}

M.config = function()
    -- g.Hexokinase_highlighters = {'virtual', 'background', 'backgroundfull'}
    g.Hexokinase_highlighters = {'sign_column'}
    g.Hexokinase_optInPatterns = {'full_hex', 'triple_hex', 'rgb', 'rgba', 'hsl', 'hsla', 'colour_names'}
end

return M
