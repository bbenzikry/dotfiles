local configure_rainbow = function()
    local to_exec = nil
    if vim.g.background == 'dark' then
        -- cmd "source ~/.config/nvim/vimscript/plugins/rainbow/dark.vim"
    else
        -- cmd "source ~/.config/nvim/vimscript/plugins/rainbow/light.vim"
    end
end

return configure_rainbow
