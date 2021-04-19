-- 'netcoredbg': {
--     "name": "netcoredbg",
--     "command": [
--       "${gadgetDir}/netcoredbg/netcoredbg",
--       "--interpreter=vscode"
--     ],
--     "attach": {
--       "pidProperty": "processId",
--       "pidSelect": "ask"
--     },
--     "configuration": {
--       "cwd": "${workspaceRoot}"
--     }

local M = {}
function M.config()
    local dap = require('dap')
    dap.configurations.cs = {{
        type = "netcoredbg",
        name = "Debug",
        request = "launch",
        program = "${file}"
    }}

    dap.adapters.netcoredbg = {
        type = 'executable',
        command = 'netcoredbg',
        args = {'--interpreter=vscode',
        '--engineLogging=${workspaceRoot}/netcoredbg.engine.log',
        '--log=${workspaceRoot}/netcoredbg.log'}
    }
end

return M
