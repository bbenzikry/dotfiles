-- local fn = vim.fn
-- local cmd = vim.cmd
-- Automatically install packer.nvim
local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])
if not packer_exists then
    vim.fn.system('git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    cmd [[packadd packer.nvim]]
end

-- Auto compile when there are changes in plugins.lua ( just here for reference, happens in files.lua )
-- cmd 'autocmd BufWritePost plugins.lua PackerCompile'

local function plugin_list(use, use_rocks)
    -- Packer itself
    use {
        'wbthomason/packer.nvim',
        opt = true
    }

    -- use_rocks {"lua-resty-http"}
    -- use_rocks {"lua-cjson"}

    -- TODO:
    -- use {
    --     "airblade/vim-rooter",
    --     config = function()
    --       vim.g.rooter_silent_chdir = 1
    --       vim.g.rooter_resolve_links = 1
    --     end
    --   }

    -- ██████████ ██
    -- ░░░░░██░░░ ░██
    --     ░██    ░██       █████  ██████████   █████
    --     ░██    ░██████  ██░░░██░░██░░██░░██ ██░░░██
    --     ░██    ░██░░░██░███████ ░██ ░██ ░██░███████
    --     ░██    ░██  ░██░██░░░░  ░██ ░██ ░██░██░░░░
    --     ░██    ░██  ░██░░██████ ███ ░██ ░██░░██████
    --     ░░     ░░   ░░  ░░░░░░ ░░░  ░░  ░░  ░░░░░░
    -- and statusline, icons, bufferline etc.

    -- use {'kaicataldo/material.vim', branch = 'main'}
    -- use 'rakr/vim-one'
    -- use 'chriskempson/base16-vim'
    use {
        'kyazdani42/nvim-web-devicons',
        opt = true,
        config = function()
            require'config.plugins.web-devicons'.config()
        end
        -- end
        -- If we want nonicons.
        -- requires = {{
        --     'yamatsum/nvim-nonicons',
        --     config = [[require 'nvim-nonicons']]
        -- }}
    }

    use 'tjdevries/colorbuddy.nvim'
    use 'bbenzikry/snazzybuddy.nvim'
    -- use 'marko-cerovac/material.nvim'

    -- Icons 
    -- use 'ryanoasis/vim-devicons'

    -- nicer buffer tabs
    use {
        'akinsho/nvim-bufferline.lua',
        config = function()
            require 'config.plugins.bufferline'
        end,
        requires = {'kyazdani42/nvim-web-devicons'}
    }

    -- use {
    --     'romgrk/barbar.nvim',
    --     event = {'VimEnter *'},
    --     config = function()
    --         require'config.plugins.barbar'.config()
    --     end,
    --     requires = {'kyazdani42/nvim-web-devicons'}
    -- }

    use {
        'glepnir/galaxyline.nvim',
        branch = 'main',
        event = {'VimEnter *'},
        config = function()
            require 'config.plugins.statusline'
        end,
        requires = {'kyazdani42/nvim-web-devicons'}
    }

    -- Startup screens, not interesting atm 
    -- use {
    --     'glepnir/dashboard-nvim', -- Beautiful dashboard upon opening Neovim
    --     config = require('config.plugins.dashboard').config()
    -- }
    --   use {
    --     'mhinz/vim-startify',
    --     config = require('plugins.misc').startify()
    -- }

    -- VSCode like light bulb
    -- use {'kosayoda/nvim-lightbulb'}

    -- Core utilities
    -- use 'mjlbach/neovim-ui' -- Useful UI utilities (might be merged into Neovim)

    use {
        'windwp/nvim-autopairs',
        event = {'BufRead *'},
        setup = function()
            vim.cmd [[packadd nvim-autopairs]]
            require("nvim-autopairs").setup()
        end
    }

    -- Commenting
    use {
        'b3nj5m1n/kommentary',
        config = function()
            require'config.plugins.kommentary'.config()
        end
    }

    -- use {
    --     'terrortylor/nvim-comment',
    --     setup = require'config.plugins.comments'.setup()
    -- }

    -- TODO: check 
    -- use {'blackCauldron7/surround.nvim', setup = require'conf.surround'.setup()}
    use 'tpope/vim-surround' -- Surround stuff with things

    -- ████████ ██               ██
    -- ░██░░░░░ ░░               ░██
    -- ░██       ██ ███████      ░██
    -- ░███████ ░██░░██░░░██  ██████
    -- ░██░░░░  ░██ ░██  ░██ ██░░░██
    -- ░██      ░██ ░██  ░██░██  ░██
    -- ░██      ░██ ███  ░██░░██████
    -- ░░       ░░ ░░░   ░░  ░░░░░░

    -- Main finder
    use {
        'nvim-telescope/telescope.nvim',
        rocks = {{
            "openssl",
            env = {
                -- Take brew version
                OPENSSL_DIR = '/usr/local/opt/openssl@1.1'
            }
        }, "lua-http-parser"},
        setup = function()
            require'config.plugins.telescope'.setup()
        end,
        config = function()
            require'config.plugins.telescope'.config()
        end,
        requires = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
            'tami5/sql.nvim',
            {
                'nvim-telescope/telescope-arecibo.nvim',
                config = function()
                    require('telescope').load_extension('arecibo')
                end,
                after = 'telescope.nvim'
            },
            {
                'nvim-telescope/telescope-github.nvim',
                config = function()
                    require('telescope').load_extension('gh')
                end,
                after = 'telescope.nvim'
            },
            {
                'nvim-telescope/telescope-project.nvim',
                config = function()
                    require('telescope').load_extension('project')
                end,
                after = 'telescope.nvim'
            },
            'nvim-telescope/telescope-cheat.nvim',
            config = function()
                require'telescope'.load_extension("cheat")
            end,
            after = 'telescope.nvim'
        }
    }

    -- TODO: search support

    -- Cool tags based viewer
    --   :Vista  <-- Opens up a really cool sidebar with info about file.
    use {
        'liuchengxu/vista.vim',
        setup = function()
            require'config.plugins.vista'.setup()
        end,
        config = function()
            require'config.plugins.vista'.config()
        end
    }

    -- ██████████
    -- ░░░░░██░░░
    --     ░██     ██████  █████   █████
    --     ░██    ░░██░░█ ██░░░██ ██░░░██
    --     ░██     ░██ ░ ░███████░███████
    --     ░██     ░██   ░██░░░░ ░██░░░░
    --     ░██    ░███   ░░██████░░██████
    --     ░░     ░░░     ░░░░░░  ░░░░░░

    use {
        'kyazdani42/nvim-tree.lua',
        -- branch = 'dev',
        after = 'nvim-web-devicons',
        setup = function()
            require'config.plugins.nvimtree'.setup()
        end,
        requires = {
            'kyazdani42/nvim-web-devicons',
            opt = true
        }
    }

    -- use 'tpope/vim-projectionist' -- Alternative files

    --     ████████                     ██
    --     ██░░░░░░   ██   ██           ░██
    --    ░██        ░░██ ██  ███████  ██████  ██████   ██   ██
    --    ░█████████  ░░███  ░░██░░░██░░░██░  ░░░░░░██ ░░██ ██
    --    ░░░░░░░░██   ░██    ░██  ░██  ░██    ███████  ░░███
    --           ░██   ██     ░██  ░██  ░██   ██░░░░██   ██░██
    --     ████████   ██      ███  ░██  ░░██ ░░████████ ██ ░░██
    --    ░░░░░░░░   ░░      ░░░   ░░    ░░   ░░░░░░░░ ░░   ░░
    -- Syntax plugins for different languages. Mostly treesitter and some specific syntax plugins

    -- Selectively use polyglot
    -- use 'sheerun/vim-polyglot'

    -- Highlighting for logs
    use "MTDL9/vim-log-highlighting"

    -- Advanced highlighting
    -- Treesitter + rainbow parentheses
    use {
        'nvim-treesitter/nvim-treesitter',
        requires = {{
            'romgrk/nvim-treesitter-context',
            after = 'nvim-treesitter'
        }, {
            'nvim-treesitter/nvim-treesitter-refactor',
            after = 'nvim-treesitter'
        }, {
            'nvim-treesitter/nvim-treesitter-textobjects',
            after = 'nvim-treesitter'
        }, {
            'nvim-treesitter/playground',
            after = 'nvim-treesitter'
        }, {
            "p00f/nvim-ts-rainbow",
            after = 'nvim-treesitter'
        }, {
            "nvim-treesitter/nvim-tree-docs",
            after = 'nvim-treesitter'
        }, {
            'JoosepAlviste/nvim-ts-context-commentstring', -- Dynamically set commentstring based on cursor location in file
            after = 'nvim-treesitter'

        }},
        run = ':TSUpdate',
        config = function()
            require'config.plugins.treesitter'.config()
        end
    }

    use {
        'windwp/nvim-ts-autotag',
        after = 'nvim-treesitter',
        config = function()
            require('nvim-ts-autotag').setup()
        end
    }

    -- Indent lines
    use {
        'lukas-reineke/indent-blankline.nvim',
        branch = 'lua',
        event = {'BufReadPre *', 'BufNewFile *'},
        config = require('config.plugins.indentline').config()
    }

    --     ██████            ██
    --     ██░░░░██          ░██
    --    ██    ░░   ██████  ░██  ██████  ██████  ██████
    --   ░██        ██░░░░██ ░██ ██░░░░██░░██░░█ ██░░░░
    --   ░██       ░██   ░██ ░██░██   ░██ ░██ ░ ░░█████
    --   ░░██    ██░██   ░██ ░██░██   ░██ ░██    ░░░░░██
    --    ░░██████ ░░██████  ███░░██████ ░███    ██████
    --     ░░░░░░   ░░░░░░  ░░░  ░░░░░░  ░░░    ░░░░░░
    -- Colors

    -- Color highlighting
    -- use {
    --     'norcalli/nvim-colorizer.lua',
    --     config = function()
    --         require"colorizer".setup()
    --     end
    -- }

    use {
        'RRethy/vim-hexokinase',
        run = "make hexokinase",
        config = require'config.plugins.hexokinase'.config()
    }

    use {'norcalli/nvim-terminal.lua'}

    -- ████     ████            ██   ██
    -- ░██░██   ██░██           ░██  ░░
    -- ░██░░██ ██ ░██  ██████  ██████ ██  ██████  ███████
    -- ░██ ░░███  ░██ ██░░░░██░░░██░ ░██ ██░░░░██░░██░░░██
    -- ░██  ░░█   ░██░██   ░██  ░██  ░██░██   ░██ ░██  ░██
    -- ░██   ░    ░██░██   ░██  ░██  ░██░██   ░██ ░██  ░██
    -- ░██        ░██░░██████   ░░██ ░██░░██████  ███  ░██
    -- ░░         ░░  ░░░░░░     ░░  ░░  ░░░░░░  ░░░   ░░
    -- motions
    use 'chaoren/vim-wordmotion'
    use 'phaazon/hop.nvim' -- EasyMotion like plugin to jump anywhere in a document

    -- ██████████                   ██   ██
    -- ░░░░░██░░░                   ░██  ░░            █████
    --     ░██      █████   ██████ ██████ ██ ███████  ██░░░██
    --     ░██     ██░░░██ ██░░░░ ░░░██░ ░██░░██░░░██░██  ░██
    --     ░██    ░███████░░█████   ░██  ░██ ░██  ░██░░██████
    --     ░██    ░██░░░░  ░░░░░██  ░██  ░██ ░██  ░██ ░░░░░██
    --     ░██    ░░██████ ██████   ░░██ ░██ ███  ░██  █████
    --     ░░      ░░░░░░ ░░░░░░     ░░  ░░ ░░░   ░░  ░░░░░
    -- Testing helpers
    --   use {
    --     'rcarriga/vim-ultest', -- Run tests on any type of code base
    --     requires = {'vim-test/vim-test'}, -- Seemless running of tests within neovim
    --     run = ':UpdateRemotePlugins',
    --     config = function() 
    -- require('config.plugins.testing').config()
    --       end
    -- }

    -- ██        ████████ ███████
    -- ░██       ██░░░░░░ ░██░░░░██
    -- ░██      ░██       ░██   ░██
    -- ░██      ░█████████░███████
    -- ░██      ░░░░░░░░██░██░░░░
    -- ░██             ░██░██
    -- ░████████ ████████ ░██
    -- ░░░░░░░░ ░░░░░░░░  ░░
    -- Language servers and completions

    -- Pictograms for LSP completions
    use {
        'onsails/lspkind-nvim',
        config = function()
            require 'config.plugins.lspkind'
        end
    }

    use {
        'neovim/nvim-lspconfig',
        rocks = {'penlight'},
        -- Seems to screw up certain load states, look into that
        -- event = {'BufRead *'}
        setup = function()
            require'config.plugins.lsp'.setup()
        end,
        config = function()
            require'config.plugins.lsp'.config()
        end,
        requires = {'mfussenegger/nvim-jdtls', {'nvim-lua/lsp-status.nvim'}, {'glepnir/lspsaga.nvim'} -- LSP UI improvements
        }
    }

    use {'kabouzeid/nvim-lspinstall'} -- Install LSP servers from within Neovim

    use {
        'hrsh7th/nvim-compe',
        event = {'InsertEnter *'},
        config = function()
            require'config.plugins.completion'.config()
        end,
        requires = {"tamago324/compe-zsh", {
            'tzachar/compe-tabnine',
            run = './install.sh'
        }}
    }

    --     ████████          ██                           ██
    --     ██░░░░░░          ░░  ██████  ██████           ░██
    --    ░██        ███████  ██░██░░░██░██░░░██  █████  ██████  ██████
    --    ░█████████░░██░░░██░██░██  ░██░██  ░██ ██░░░██░░░██░  ██░░░░
    --    ░░░░░░░░██ ░██  ░██░██░██████ ░██████ ░███████  ░██  ░░█████
    --           ░██ ░██  ░██░██░██░░░  ░██░░░  ░██░░░░   ░██   ░░░░░██
    --     ████████  ███  ░██░██░██     ░██     ░░██████  ░░██  ██████
    --    ░░░░░░░░  ░░░   ░░ ░░ ░░      ░░       ░░░░░░    ░░  ░░░░░░
    -- snippets

    use 'rafamadriz/friendly-snippets'
    use 'hrsh7th/vim-vsnip'

    --     ████████  ██   ██
    --     ██░░░░░░██░░   ░██
    --    ██      ░░  ██ ██████
    --   ░██         ░██░░░██░
    --   ░██    █████░██  ░██
    --   ░░██  ░░░░██░██  ░██
    --    ░░████████ ░██  ░░██
    --     ░░░░░░░░  ░░    ░░
    -- Git and git helpers 

    -- use gy to for visual selection
    use {
        'ruifm/gitlinker.nvim',
        requires = 'nvim-lua/plenary.nvim',
    }

    -- use 'tpope/vim-fugitive'

    -- Git status signs in the gutter
    use {
        'lewis6991/gitsigns.nvim',
        branch = 'main',
        event = {'BufReadPre *', 'BufNewFile *'},
        setup = function()
            require'config.plugins.git'.setup()
        end,
        requires = {'nvim-lua/plenary.nvim'}
    }

    --  message committer
    use 'rhysd/committia.vim'

    -- Floating windows
    use 'rhysd/git-messenger.vim'

    -- Formatting 
    -- use 'sbdchd/neoformat'

    -- Github integration
    -- use {
    --     "pwntester/octo.nvim",
    --     cmd = "Octo",
    --     after = 'telescope.nvim',
    --     config = function()
    --         require("telescope").load_extension("octo")
    --     end
    -- }

    -- ██
    -- ░██
    -- ░██       ██   ██  ██████
    -- ░██      ░██  ░██ ░░░░░░██
    -- ░██      ░██  ░██  ███████
    -- ░██      ░██  ░██ ██░░░░██
    -- ░████████░░██████░░████████
    -- ░░░░░░░░  ░░░░░░  ░░░░░░░░

    -- Lua and teal
    use 'teal-language/vim-teal'

    -- Lua dev scratchpad
    -- use 'bfredl/nvim-luadev'

    -- lua/nvim DAP support
    use 'jbyuki/lua-debug.nvim'

    use {
        "rafcamlet/nvim-luapad",
        cmd = "Luapad",
        ft = "lua"
    }

    -- TODO: tjdevries/nlua.nvim

    --     ████████            ██
    --     ██░░░░░░██          ░██                     █████
    --    ██      ░░   ██████  ░██  ██████   ███████  ██░░░██
    --   ░██          ██░░░░██ ░██ ░░░░░░██ ░░██░░░██░██  ░██
    --   ░██    █████░██   ░██ ░██  ███████  ░██  ░██░░██████
    --   ░░██  ░░░░██░██   ░██ ░██ ██░░░░██  ░██  ░██ ░░░░░██
    --    ░░████████ ░░██████  ███░░████████ ███  ░██  █████
    --     ░░░░░░░░   ░░░░░░  ░░░  ░░░░░░░░ ░░░   ░░  ░░░░░
    -- Golang 
    use 'buoto/gotests-vim'
    -- use 'fatih/vim-go' -- TODO: see how this interacts with LSP / DAP

    --     ████████                    ██
    --     ██░░░░░░                    ░██
    --    ░██         █████   ██████   ░██  ██████
    --    ░█████████ ██░░░██ ░░░░░░██  ░██ ░░░░░░██
    --    ░░░░░░░░██░██  ░░   ███████  ░██  ███████
    --           ░██░██   ██ ██░░░░██  ░██ ██░░░░██
    --     ████████ ░░█████ ░░████████ ███░░████████
    --    ░░░░░░░░   ░░░░░   ░░░░░░░░ ░░░  ░░░░░░░░
    -- Scala
    use 'scalameta/nvim-metals'

    -- ██       ██
    -- ░██      ░░          ██████
    -- ░██       ██  ██████░██░░░██  ██████
    -- ░██      ░██ ██░░░░ ░██  ░██ ██░░░░
    -- ░██      ░██░░█████ ░██████ ░░█████
    -- ░██      ░██ ░░░░░██░██░░░   ░░░░░██
    -- ░████████░██ ██████ ░██      ██████
    -- ░░░░░░░░ ░░ ░░░░░░  ░░      ░░░░░░
    -- Lisps: Mainly for clojure. Conjure + Aniseed helps with writing Fennel for configuration as well :)

    use 'guns/vim-sexp'
    use 'tpope/vim-sexp-mappings-for-regular-people'
    use {
        "Olical/aniseed",
        branch = 'develop',
        config = function()
            vim.cmd [[doautocmd User FennelLoaded]]
        end
    }
    use {
        "Olical/conjure",
        ft = {"fennel", "clojure"},
        config = function()
            require'config.plugins.conjure'.config()
        end
    }
    use {
        "clojure-vim/vim-jack-in",
        ft = "clojure"
    }
    use {
        "eraserhd/parinfer-rust",
        run = "cargo build --release",
        ft = {"clojure", "fennel", "lisp", "scheme"}
    }

    -- Janet
    use 'bakpakin/janet.vim'

    --     ████     ██ ████████ ██████████
    --     ░██░██   ░██░██░░░░░ ░░░░░██░░░
    --     ░██░░██  ░██░██          ░██
    --     ░██ ░░██ ░██░███████     ░██
    --     ░██  ░░██░██░██░░░░      ░██
    --     ░██   ░░████░██          ░██
    --     ░██    ░░███░████████    ░██
    -- ░██ ░░      ░░░ ░░░░░░░░     ░░

    -- TODO: maybe omnisharp-vim

    -- ███████           ██
    -- ░██░░░░██         ░██               █████
    -- ░██    ░██  █████ ░██      ██   ██ ██░░░██
    -- ░██    ░██ ██░░░██░██████ ░██  ░██░██  ░██
    -- ░██    ░██░███████░██░░░██░██  ░██░░██████
    -- ░██    ██ ░██░░░░ ░██  ░██░██  ░██ ░░░░░██
    -- ░███████  ░░██████░██████ ░░██████  █████
    -- ░░░░░░░    ░░░░░░ ░░░░░    ░░░░░░  ░░░░░

    use {
        -- Debug Adapter Protocol client
        'mfussenegger/nvim-dap',
        -- opt = true,
        requires = {'mfussenegger/nvim-jdtls', {'mfussenegger/nvim-dap-python'}, {'theHamsta/nvim-dap-virtual-text'}, {
            'nvim-telescope/telescope-dap.nvim',
            after = 'telescope.nvim'
        }},
        setup = function()
            require'config.plugins.dap'.setup()
        end,
        config = function()
            require'config.plugins.dap'.config()
        end
    }

    use {
        'kassio/neoterm',
        cmd = {'Ttoggle'},
        config = function()
            require'config.plugins.neoterm'.config()
        end
    }

    -- TODO: java extension use 'mfussenegger/nvim-jdtls'

    --     ██
    --     ░██
    --    ██████ ██████████  ██   ██ ██   ██
    --   ░░░██░ ░░██░░██░░██░██  ░██░░██ ██
    --     ░██   ░██ ░██ ░██░██  ░██ ░░███
    --     ░██   ░██ ░██ ░██░██  ░██  ██░██
    --     ░░██  ███ ░██ ░██░░██████ ██ ░░██
    --      ░░  ░░░  ░░  ░░  ░░░░░░ ░░   ░░

    use {
        'christoomey/vim-tmux-navigator',
        cond = function()
            return os.getenv('TMUX')
        end,
        setup = function()
            vim.cmd [[packadd vim-tmux-navigator]]
        end
    }

    -- ███████   ██████
    -- ░██░░░░██ ░█░░░░██
    -- ░██    ░██░█   ░██
    -- ░██    ░██░██████
    -- ░██    ░██░█░░░░ ██
    -- ░██    ██ ░█    ░██
    -- ░███████  ░███████
    -- ░░░░░░░   ░░░░░░░

    -- cypher highlighting 
    use {'neo4j-contrib/cypher-vim-syntax'}

    -- Database explorer
    use {
        "kristijanhusak/vim-dadbod-ui",
        cmd = {"DBUI"},
        requires = {
            "tpope/vim-dadbod",
            opt = true
        },
        {
            "kristijanhusak/vim-dadbod-completion",
            opt = true
        }
    }

    -- TODO: documentation
    -- use "kkoomen/vim-doge"

    -- Versioning
    use 'meain/vim-package-info'

    -- ██       ██        ██   ██   ██
    -- ░██      ░██       ░░   ░██  ░░            █████
    -- ░██   █  ░██ ██████ ██ ██████ ██ ███████  ██░░░██
    -- ░██  ███ ░██░░██░░█░██░░░██░ ░██░░██░░░██░██  ░██
    -- ░██ ██░██░██ ░██ ░ ░██  ░██  ░██ ░██  ░██░░██████
    -- ░████ ░░████ ░██   ░██  ░██  ░██ ░██  ░██ ░░░░░██
    -- ░██░   ░░░██░███   ░██  ░░██ ░██ ███  ░██  █████
    -- ░░       ░░ ░░░    ░░    ░░  ░░ ░░░   ░░  ░░░░░

    -- use 'godlygeek/tabular'
    use 'junegunn/vim-easy-align'
    use 'plasticboy/vim-markdown'
    -- Table mode
    use 'dhruvasagar/vim-table-mode'

    -- ████     ████ ██
    -- ░██░██   ██░██░░
    -- ░██░░██ ██ ░██ ██  ██████  █████
    -- ░██ ░░███  ░██░██ ██░░░░  ██░░░██
    -- ░██  ░░█   ░██░██░░█████ ░██  ░░
    -- ░██   ░    ░██░██ ░░░░░██░██   ██
    -- ░██        ░██░██ ██████ ░░█████
    -- ░░         ░░ ░░ ░░░░░░   ░░░░░
    -- misc plugins

    -- Normal mkdir
    use "pbrisbin/vim-mkdir"

    -- Window selection, :Chowcho
    use {'tkmpypy/chowcho.nvim'}

    -- Maybe
    -- { "alx741/neoman.vim", cmd = "Neoman" },

    -- Close / open HTML tags with > / <
    use 'alvan/vim-closetag'

    -- Sessions per Git branch, easy session switching and also auto-starts sessions
    use {
        'dhruvasagar/vim-prosession',
        config = function()
            require('config.plugins.prosession').config()
        end,
        requires = 'tpope/vim-obsession' -- Continuously update session files
    }

    -- Resize unfocused buffers + cool animations
    use {'camspiers/lens.vim'}

    use {
        'radenling/vim-dispatch-neovim',
        requires = {'tpope/vim-dispatch'}
    }

    -- Fade unfocused buffers
    use 'TaDaa/vimade'
    -- Substitution helpers
    use 'tpope/vim-abolish'

    -- Project-specific settings
    use 'editorconfig/editorconfig-vim'

    -- use 'nvim-lua/popup.nvim' -- Popup support ( not in upstream yet ), required by telescope
    -- Startup time / plugin monitor
    use 'dstein64/vim-startuptime'

    -- Quick exit
    use 'mhinz/vim-sayonara'

    -- Currently screwes up undo https://github.com/axelf4/vim-strip-trailing-whitespace/issues/5
    -- use 'axelf4/vim-strip-trailing-whitespace'

    -- Better scrolling
    use {
        "karb94/neoscroll.nvim",
        config = function()
            vim.g.neoscroll_cursor_scrolls_alone = 1
            require'neoscroll'.setup()
        end
    }

    -- URL highlighting
    use {
        "itchyny/vim-highlighturl",
        config = [[vim.g.highlighturl_guifg = "NONE"]]
    }

    -- Zen mode
    use {'junegunn/goyo.vim'}

    -- Use :Limitlight to dim all lines except the current one
    use {'junegunn/limelight.vim'}

    -- In yo face comments
    use {'tjdevries/vim-inyoface'}

    -- Scrollbars in Neovim
    use {
        'dstein64/nvim-scrollview',
        event = {'VimEnter *'},
        config = function()
            require('config.plugins.scrollview')()
        end
    }

    use {
        "nacro90/numb.nvim",
        config = function()
            require('numb').setup()
        end
    }

    -- use {'voldikss/vim-floaterm'} -- Use the terminal in a floating window

    -- use 'goodell/vim-mscgen'

    -- use 'brooth/far.vim' -- Find and replace
    -- use 'echorin/any-jump.vim'

end

local packer = require('packer').startup {plugin_list}

-- install plugins during initial bootstrap
if not packer_exists then
    packer.install()
end

-- TODO: maybe compile as well

return packer
