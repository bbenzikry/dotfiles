local lsp_status = require 'lsp-status'
local lspconfig = require 'lspconfig'

local efm_config = os.getenv('HOME') .. '/.config/efm-langserver/config.yaml'
local log_dir = "/tmp/"
local black = require "config.plugins.lsp.efm.black"
local isort = require "config.plugins.lsp.efm.isort"
local mypy = require "config.plugins.lsp.efm.mypy"
local lua_format = require "config.plugins.lsp.efm.lua-format"
local prettier = require "config.plugins.lsp.efm.prettier"
local eslint = require "config.plugins.lsp.efm.eslint"
local eslint_d = require "config.plugins.lsp.efm.eslint_d"
local rustfmt = require "config.plugins.lsp.efm.rustfmt"
local gofmt = require "config.plugins.lsp.efm.gofmt"

-- Note: we install the lua language server with :LSPInstall lua
local sumneko_bin_path = vim.fn.stdpath('data') .. '/lspinstall/lua/sumneko-lua-language-server'

return {
    -- https://github.com/mads-hartmann/bash-language-server
    bashls = {},
    -- https://github.com/snoe/clojure-lsp
    clojure_lsp = {},
    -- Scala / metals https://scalameta.org/metals/docs/editors/vim.html#using-an-alternative-lsp-client -- we're using nvim-metals instead
    -- metals = {},
    -- https://github.com/regen100/cmake-language-server
    cmake = {},
    -- https://clangd.llvm.org/installation.html
    clangd = {
        cmd = {'clangd', '--background-index', '--clang-tidy', '--completion-style=bundled', '--header-insertion=iwyu',
               '--suggest-missing-includes', '--cross-file-rename'},
        handlers = lsp_status.extensions.clangd.setup(),
        init_options = {
            clangdFileStatus = true,
            usePlaceholders = true,
            completeUnimported = true,
            semanticHighlighting = true
        }
    },
    -- CSS ( https://github.com/vscode-langservers/vscode-css-languageserver-bin ) 
    cssls = {
        filetypes = {"css", "scss", "less", "sass"},
        root_dir = lspconfig.util.root_pattern("package.json", ".git")
    },
    ghcide = {},
    html = {},
    julials = {
        settings = {
            julia = {
                format = {
                    indent = 2
                }
            }
        }
    },
    ocamllsp = {},
    pyright = {
        settings = {
            python = {
                formatting = {
                    provider = 'yapf'
                }
            }
        }
    },
    -- LUA ( https://github.com/sumneko/lua-language-server )
    sumneko_lua = {
        cmd = {sumneko_bin_path},
        filetypes = {"lua"},
        settings = {
            Lua = {
                diagnostics = {
                    globals = {'vim'}
                },
                runtime = {
                    version = 'LuaJIT',
                    path = vim.split(package.path, ';')
                },
                completion = {
                    keywordSnippet = true
                },
                hint = {
                    enable = true
                },
                workspace = {
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
                    }
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false
                }
            }
        }
    },
    -- latex
    -- texlab = {
    --   settings = {
    --     latex = {forwardSearch = {executable = 'okular', args = {'--unique', 'file:%p#src:%l%f'}}}
    --   },
    --   commands = {
    --     TexlabForwardSearch = {
    --       function()
    --         local pos = vim.api.nvim_win_get_cursor(0)
    --         local params = {
    --           textDocument = {uri = vim.uri_from_bufnr(0)},
    --           position = {line = pos[1] - 1, character = pos[2]}
    --         }
    --         lsp.buf_request(0, 'textDocument/forwardSearch', params,
    --                         function(err, _, _, _) if err then error(tostring(err)) end end)
    --       end,
    --       description = 'Run synctex forward search'
    --     }
    --   }
    -- },
    -- Typescript https://github.com/theia-ide/typescript-language-server
    tsserver = {},
    -- https://github.com/iamcco/vim-language-server 
    vimls = {},
    terraformls = {},
    -- https://github.com/rcjsuen/dockerfile-language-server-nodejs
    dockerls = {},
    gopls = {
        cmd = {"gopls", "serve"},
        settings = {
            gopls = {
                analyses = {
                    unusedparams = true
                },
                staticcheck = true
            }
        },
        init_options = {
            usePlaceholders = true
        }
    },
    rust_analyzer = {},
    --- JSON ( https://github.com/vscode-langservers/vscode-json-languageserver )
    jsonls = {
        cmd = {'json-languageserver', '--stdio'},
        settings = {
            json = {
                schemas = {{
                    fileMatch = {'jsconfig.json'},
                    url = 'https://json.schemastore.org/jsconfig'
                }, {
                    fileMatch = {'tsconfig.json'},
                    url = 'https://json.schemastore.org/tsconfig'
                }, {
                    fileMatch = {'package.json'},
                    url = 'https://json.schemastore.org/package'
                }}
            }
        }
    },
    -- https://github.com/graphql/graphiql/tree/main/packages/graphql-language-service-cli
    graphql = {},
    -- YAML ( https://github.com/redhat-developer/yaml-language-server )
    yamlls = {
        settings = {
            yaml = {
                schemas = {
                    ['http://json.schemastore.org/gitlab-ci'] = '.gitlab-ci.yml',
                    ['http://json.schemastore.org/composer'] = 'composer.yaml',
                    ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = 'docker-compose*.yml',
                    ['https://raw.githubusercontent.com/kamilkisiela/graphql-config/v3.0.3/config-schema.json'] = '.graphqlrc*'
                }
            }
        }
    },
    vuels = {
        settings = {
            vetur = {
                experimental = {
                    templateInterpolationService = true
                },
                validation = {
                    templateProps = true
                },
                completion = {
                    tagCasing = 'initial'
                }
            }
        }
    },
    -- https://github.com/mattn/efm-langserver,
    efm = {
        cmd = {"efm-langserver", "-c", efm_config, "-logfile", log_dir .. "efm.log"},
        filetypes = {"python", "yaml", "json", "markdown", "rst", "html", "css", "javascript", "typescript",
                     "javascriptreact", "typescriptreact", "dockerfile"},
        -- Fallback to .bashrc as a project root to enable LSP on loose files
        root_dir = function(fname)
            return lspconfig.util.root_pattern("tsconfig.json")(fname) or
                       lspconfig.util.root_pattern(".eslintrc.js", ".git")(fname) or
                       lspconfig.util.root_pattern("package.json", ".git/", ".zshrc")(fname);
        end,
        init_options = {
            documentFormatting = true
        },
        settings = {
            rootMarkers = {"package.json", "go.mod", ".git/", ".zshrc", "Cargo.toml"},
            languages = {
                python = {isort, black},
                lua = {lua_format},
                yaml = {prettier},
                json = {prettier},
                markdown = {prettier},
                html = {prettier},
                css = {prettier},
                javascript = {prettier, eslint_d},
                typescript = {prettier, eslint_d},
                javascriptreact = {prettier, eslint_d},
                typescriptreact = {prettier, eslint_d}
                -- rust = {rustfmt}, -- not needed with rust_analyzer
                -- go = {gofmt}, -- not needed with gopls
            }
        }
    }

    -- TODO: https://github.com/prominic/groovy-language-server.git
}

