local M = {}

function M.setup()
    -- If we want this as opt 
    -- vim.cmd [[packadd nvim-dap]]
    -- vim.cmd [[packadd nvim-dap-python]]
    -- vim.cmd [[packadd nvim-dap-virtual-text]]
end

function M.config()
    -- Note: doesn't work with go
    -- vim.g.dap_virtual_text = "all frames"
    vim.g.dap_virtual_text = true
    local dap = require('dap')

    vim.fn.sign_define('DapBreakpoint', {
        -- text = '',
        text = '🛑',
        texthl = 'DebugBreakpoint',
        linehl = '',
        numhl = 'DebugBreakpoint'
    })
    vim.fn.sign_define('DapStopped', {
        text = '',
        texthl = 'DebugHighlight',
        linehl = 'DebugHighlight',
        numhl = 'DebugHighlight'
    })

    local function load_telescope()
        local has_telescope = pcall(require, 'telescope')
        local dap_ts_ok = pcall(cmd, 'packadd telescope-dap.nvim')

        if not has_telescope or not dap_ts_ok then
            do
                return
            end
        end

        local telescope_dap = require('telescope').load_extension('dap')

        local options = {
            shorten_path = false,
            height = 3,
            layout_config = {
                preview_width = 0.6
            }
        }
        -- Telescope dap control functions
        function _G.__telescope_breakpoints()
            telescope_dap.list_breakpoints(options)
        end
    end

    -- DAP control functions
    function _G.__dap_start()
        -- We automatically add configurations as defined by vscode
        -- Note that this currently only works well with local changes to nvim-dap
        require('dap.ext.vscode').load_launchjs()
        dap.continue()
        vim.wo.signcolumn = 'auto:2'
    end
    function _G.__dap_exit()
        dap.disconnect()
        vim.wo.signcolumn = 'auto'
    end

    -- DAP telescope

    -- Key bindings
    local opts = {
        noremap = true,
        silent = true
    }

    load_telescope()

    -- Configure available debuggers
    require'config.plugins.dap.debuggers'.init()

    -- Decide on right keybindings
    utils.map_lua('n', '<leader>ds', "__dap_start()", opts)
    utils.map_lua('n', '<leader>dq', "__dap_exit()", opts)
    utils.map_lua('n', '<leader>do', "require'dap'.step_over()", opts)
    utils.map_lua('n', '<leader>di', "require'dap'.step_into()", opts)
    utils.map_lua('n', '<leader>db', "require'dap'.toggle_breakpoint()", opts)
    utils.map_lua('n', '<leader>dr', "require'dap'.repl.open()", opts)
    utils.map_lua('n', '<leader>dn', "require'dap-python'.test_method()", opts)
    utils.map_lua('n', '<leader>dt', '__telescope_breakpoints()', opts)

    -- TODO: debug selection generic
    -- vim.api.nvim_set_keymap('v', '<leader>ds', "<ESC>:lua require'dap-python'.debug_selection()<CR>", opts)
end

return M
