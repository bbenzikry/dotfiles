local lspconfig = require 'lspconfig'
-- https://github.com/teal-language/teal-language-server
return {
    teal = {
        default_config = {
            cmd = {"teal-language-server"},
            filetypes = {"teal"},
            root_dir = lspconfig.util.root_pattern("tlconfig.lua", ".git"),
            settings = {}
        }
    }
}
