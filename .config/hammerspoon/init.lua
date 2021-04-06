require "hs.ipc"

-- Ensure the IPC command line client is available
hs.ipc.cliInstall()

-- Stackline configuration ( see: https://github.com/AdamWagner/stackline/wiki/Configuring-stackline)
local stacklineOpts = {
    appearance = { 
      showIcons = true,
      iconPadding = 4,
      offset = {
          y = 0,
        --   x = 9,
      }
    },
    features = {
        clickToFocus = true,  -- default is true
    },
}

-- Load stackline 
stackline = require "stackline.stackline.stackline"
stackline:init(stacklineOpts)
