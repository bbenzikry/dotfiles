-- local ok, env = pcall(require, 'packer')
function _G._fennel_init()
    require('aniseed.env').init({
        module = 'vimconf.init'
    })
end

-- We need this setup prior to aniseed load.
-- vim.g.aniseed_env = true

exec([[
        augroup fennel_load
        autocmd! 
        autocmd User FennelLoaded lua _fennel_init()
        augroup END
]], false)

