local M = {}

-- Note: clojure and other lisps are not here as we use Conjure
local debuggers = {'cxxrust', 'dart', 'go', 'haskell', 'java', 'javascript', 'lua', 'mock', 'netcoredbg', 'python',
                   'ruby'}
function M.init()
    -- local can_popup, popup = pcall(require, 'popup')
    for _, debugger in ipairs(debuggers) do
        local ok, instance = pcall(require, 'config.plugins.dap.debuggers.' .. debugger)
        if ok then
            instance.config()
        else
            local message = 'could not load debugger configuration for ' .. debugger
            print(message)
        end
    end
end

return M
