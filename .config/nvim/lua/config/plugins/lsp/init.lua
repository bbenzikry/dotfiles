local M = {}

function M.setup()
    -- require("vim.lsp.protocol").CompletionItemKind = {
    --     " [Text]", -- Text
    --     " [Method]", -- Method
    --     "ƒ [Function]", -- Function
    --     " [Constructor]", -- Constructor
    --     "識 [Field]", -- Field
    --     " [Variable]", -- Variable
    --     "\u{f0e8} [Class]", -- Class
    --     "ﰮ [Interface]", -- Interface
    --     " [Module]", -- Module
    --     " [Property]", -- Property
    --     " [Unit]", -- Unit
    --     " [Value]", -- Value
    --     "了 [Enum]", -- Enum
    --     " [Keyword]", -- Keyword
    --     " [Snippet]", -- Snippet
    --     " [Color]", -- Color
    --     " [File]", -- File
    --     "渚 [Reference]", -- Reference
    --     " [Folder]", -- Folder
    --     " [Enum]", -- Enum
    --     " [Constant]", -- Constant
    --     " [Struct]", -- Struct
    --     "鬒 [Event]", -- Event
    --     "\u{03a8} [Operator]", -- Operator
    --     " [Type Parameter]" -- TypeParameter
    --   }
    vim.cmd [[packadd lsp-status.nvim]]
    vim.cmd [[packadd nvim-lspconfig]]
    vim.fn.sign_define("LspDiagnosticsSignError", {
        text = "",
        texthl = "LspDiagnosticsDefaultError"
    })
    vim.fn.sign_define("LspDiagnosticsSignWarning", {
        text = "",
        texthl = "LspDiagnosticsDefaultWarning"
    })
    vim.fn.sign_define("LspDiagnosticsSignInformation", {
        text = "",
        texthl = "LspDiagnosticsDefaultInformation"
    })
    vim.fn.sign_define("LspDiagnosticsSignHint", {
        text = "",
        texthl = "LspDiagnosticsDefaultHint"
    })
    -- vim.fn.sign_define("LightBulbSign", {
    --     text = "⋄",
    --     texthl = "Number",
    --     linehl = "",
    --     numhl = ""
    -- })

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        signs = {
            enable = false,
            priority = 20
        },
        -- virtual_text = true,
        virtual_text = {
            spacing = 4,
            prefix = ' ',
            severity_limit = "Warning"
        },
        update_in_insert = false -- delay update
    })

    -- Handle formatting in a smarter way
    -- If the buffer has been edited before formatting has completed, do not try to
    -- apply the changes, by Lukas Reineke
    vim.lsp.handlers['textDocument/formatting'] = function(err, _, result, _, bufnr)
        if err ~= nil or result == nil then
            return
        end

        -- If the buffer hasn't been modified before the formatting has finished,
        -- update the buffer
        if not vim.api.nvim_buf_get_option(bufnr, 'modified') then
            local view = vim.fn.winsaveview()
            vim.lsp.util.apply_text_edits(result, bufnr)
            vim.fn.winrestview(view)
            if bufnr == vim.api.nvim_get_current_buf() then
                vim.api.nvim_command('noautocmd :update')

                -- Trigger post-formatting autocommand which can be used to refresh gitgutter
                vim.api.nvim_command('silent doautocmd <nomodeline> User FormatterPost')
            end
        end
    end

    function _G.reload_lsp()
        vim.lsp.stop_client(vim.lsp.get_active_clients())
        cmd [[edit]]
    end
    function _G.open_lsp_log()
        local path = vim.lsp.get_log_path()
        cmd("edit " .. path)
    end
    cmd('command! -nargs=0 LspLog call v:lua.open_lsp_log()')
    cmd('command! -nargs=0 LspRestart call v:lua.reload_lsp()')
end

function M.config()
    local lspconfig = require 'lspconfig'
    local configs = require 'lspconfig/configs'

    local lsp_status = require 'lsp-status'
    local saga = require 'lspsaga'
    -- If we want to overwrite defaults
    -- lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
    -- })

    lsp_status.register_progress()
    -- client log level
    vim.lsp.set_log_level('info')

    -- Saga
    saga.init_lsp_saga {
        use_saga_diagnostic_sign = true,
        code_action_keys = {
            quit = '<esc>',
            exec = '<cr>'
        },
        finder_action_keys = {
            -- vsplit = "v",
            -- split = "s",
            quit = {"q", "<ESC>"}
        },
        code_action_icon = '✨',
        code_action_prompt = {
            enable = true,
            sign = false,
            -- sign_priority = 1500,
            virtual_text = false
        }
    }

    function _G._show_saga_diagnostics()
        if vim.fn.mode() == 'n' then
            -- require('lspsaga.diagnostic').show_line_diagnostics()
            require('lspsaga.diagnostic').show_cursor_diagnostics()
            -- local npairs = require("nvim-autopairs")
            -- return npairs.check_break_line_char()
        end
    end

    function _G.lsp_hover_doc()
        -- if vim.fn.complete_info() ~= nil then
        -- require('lspsaga.hover').close_hover_window()
        -- end
        require('lspsaga.hover').render_hover_doc()
    end

    local on_attach = function(client, bufnr)
        if client.config.flags then
            client.config.flags.allow_incremental_sync = true
        end
        lsp_status.on_attach(client)
        local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
        end
        local function buf_set_option(...)
            vim.api.nvim_buf_set_option(bufnr, ...)
        end

        -- omni completion source
        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        local opts = {
            noremap = true,
            silent = true
        }

        -- Old key maps, for reference.
        -- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        -- buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
        -- -- buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)

        -- -- Saga
        -- buf_set_keymap('n', 'K', [[<cmd>lua require('lspsaga.hover').render_hover_doc()<cr>]], opts)
        -- buf_set_keymap('n', '<leader>rn', [[<cmd>lua require('lspsaga.rename').rename()<CR>]], opts)
        -- buf_set_keymap('n', '<leader>ca', [[<cmd>lua require('lspsaga.codeaction').code_action()<cr>]], opts)
        -- -- Show diagnostics popup with <leader>d
        -- buf_set_keymap('n', '<leader>d', [[<cmd>lua require('lspsaga.diagnostic').show_line_diagnostics()<cr>]], opts)

        -- -- buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        -- -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        -- buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        -- buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        -- buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        -- buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        -- buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
        -- buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
        -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
        -- buf_set_keymap('n', '<leader>ls', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
        -- buf_set_keymap('n', '<leader>lS', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
        -- others
        -- buf_set_keymap('n', 'Lo', ':LspOrganize<CR>', {silent = true})
        -- buf_set_keymap('n', 'Lf', ':LspFixCurrent<CR>', {silent = true})
        -- buf_set_keymap('n', 'Lr', ':LspRenameFile<CR>', {silent = true})
        -- buf_set_keymap('n', 'Li', ':LspImportAll<CR>', {silent = true})

        if client.resolved_capabilities.implementation then
            utils.map("n", "gD", "vim.lsp.buf.implementation()")
        end

        -- Set autocommands conditional on server_capabilities
        if client.resolved_capabilities.document_formatting then
            vim.api.nvim_exec([[
                augroup format_on_save
                  autocmd! * <buffer>
                  autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()
                augroup END
              ]], false)

            utils.map("n", "<leader>fo", "<cmd>lua vim.lsp.buf.formatting()<CR>", {
                silent = true
            })

        elseif client.resolved_capabilities.document_range_formatting then
            utils.map("n", "<leader>for", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", {
                silent = true
            })
        end

        if client.resolved_capabilities.document_highlight then
            utils.create_augroups({{'CursorHold,CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()'},
                                   {'CursorMoved,CursorMovedI <buffer> lua vim.lsp.buf.clear_references()'}},
                'lsp_document_highlight')
        end

        if client.resolved_capabilities.code_action then
            -- If we want the code action light bulb 
            -- vim.cmd [[packadd nvim-lightbulb]]
            -- vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
            buf_set_keymap('n', '<leader>ca', '<cmd>lua require\'telescope.builtin\'.lsp_code_actions()<CR>', opts)
        end

        -- autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()

        -- vim.api.nvim_exec([[
        --     augroup lsp_line_diag
        --     autocmd!
        --     autocmd CursorHold * lua _show_saga_diagnostics()
        --     augroup END
        -- ]], false)

        vim.api.nvim_exec([[
        augroup lsp_signature_help
          autocmd! * <buffer>
          autocmd CursorHoldI * silent! lua require('lspsaga.signaturehelp').signature_help()
        augroup END
        ]], false)

        -- Note: the variable is here to prevent flickering on CursorHold ( see: )
        -- vim.api.nvim_exec([[
        --     augroup lsp_hoverdoc
        --       autocmd! * <buffer>
        --       autocmd CursorHoldI <buffer> lua if vim.api.nvim_buf_get_var(0, 'lsp_hoverdoc') == 0 then lsp_hover_doc(); vim.api.nvim_buf_set_var(0, 'lsp_hoverdoc',1) end
        --       autocmd CursorMovedI <buffer> lua require('lspsaga.hover').close_hover_window(); vim.api.nvim_buf_set_var(0,'lsp_hoverdoc', 0); 
        --     augroup END
        --   ]], false)

        print("LSP attached.")
    end

    -- override defaults in lsp config
    local defaults = require 'config.plugins.lsp.defaults'

    for server, default in pairs(defaults) do
        configs[server] = default
    end

    -- Signature help every time a selection is made. 
    -- vim.cmd [[autocmd User CompeConfirmDone :Lspsaga signature_help]]
    local servers = require 'config.plugins.lsp.servers'

    for server, config in pairs(servers) do
        if config['attach_function'] then
            config.on_attach = config.attach_function(on_attach)
        else
            config.on_attach = on_attach
        end
        if not config.capabilities then
            config.capabilities = vim.lsp.protocol.make_client_capabilities()
        end
        config.capabilities.textDocument.completion.completionItem.snippetSupport = true
        config.capabilities.textDocument.completion.completionItem.resolveSupport =
            {
                properties = {"documentation", "detail", "additionalTextEdits"}
            }
        config.capabilities = vim.tbl_deep_extend('keep', config.capabilities, lsp_status.capabilities)
        -- if server == 'omnisharp' then
        --     require'pl.pretty'.dump(config)
        -- end
        if lspconfig[server] and lspconfig[server].setup ~= nil then
            lspconfig[server].setup(config)
        end

        -- end
    end

    -- Key bindings
    utils.map_lua("n", "ga", "require('lspsaga.codeaction').code_action()")
    utils.vmap_lua("ga", "require('lspsaga.codeaction').range_code_action()")
    utils.map_lua("n", "gf", "require('lspsaga.provider').lsp_finder()")
    utils.map_lua("n", "gs", "require('lspsaga.signaturehelp').signature_help()")
    utils.map_lua("n", "gr", "require('lspsaga.rename').rename()")

    -- Hover and definitions with scroll ability
    utils.map_lua("n", "K", "require('lspsaga.hover').render_hover_doc()")
    utils.map_lua("n", "gd", "require('lspsaga.provider').preview_definition()")

    -- diagnostic
    utils.map_lua("n", "<leader>d", "require('lspsaga.diagnostic').show_line_diagnostics()")
    utils.map_lua("n", "gn", "require('lspsaga.diagnostic').lsp_jump_diagnostic_next()")
    utils.map_lua("n", "gp", "require('lspsaga.diagnostic').lsp_jump_diagnostic_prev()")

end

return M
