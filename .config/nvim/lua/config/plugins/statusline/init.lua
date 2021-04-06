vim.cmd [[packadd galaxyline.nvim]]
vim.cmd [[packadd nvim-web-devicons]]

local gl = require('galaxyline')
local utils = require('common.utils')
local condition = require('galaxyline.condition')
local fileinfo = require('galaxyline.provider_fileinfo')

local gls = gl.section
gl.short_line_list = {'packer', 'floaterm', 'dap-repl', 'help', 'NvimTree', 'vista', 'dbui'}

--- Colors & Settings
local MODE_ALIASES = {
    [110] = 'NORMAL',
    [105] = 'INSERT',
    [99] = 'COMMAND',
    [116] = 'TERMINAL',
    [118] = 'VISUAL',
    [22] = 'V-BLOCK',
    [86] = 'V-LINE',
    [82] = 'REPLACE',
    [115] = 'SELECT',
    [83] = 'S-LINE'
}

local dark = {
    bg = '#282a36',
    fg = '#eff0eb',
    section_fg = '#eff0eb',
    section_bg = '#38393f',
    error = '#ff5c57',
    red = '#ff5c57',
    green = '#5af78e',
    yellow = '#f3f99d',
    blue = '#57c7ff',
    purple = '#ff6ac1',
    gray = '#4c4f55',

    -- mode colors
    NORMAL = '#5af78e', -- green
    INSERT = '#57c7ff', -- blue
    COMMAND = '#f3f99d', -- yellow
    VISUAL = '#ff6ac1', -- purple
    ['V-BLOCK'] = '#ff6ac1', -- purple
    REPLACE = '#ff5c57', -- red
    SELECT = '#5af78e', -- green
    TERMINAL = '#5af78e', -- green
    ['S-LINE'] = '#5af78e', -- green
    ['V-LINE'] = '#5af78e', -- green

    -- -- mode colors
    -- normal = '#98c379', -- green
    -- insert = '#61afef', -- blue
    -- command = '#e5c07b', -- yellow
    -- visual = '#c678dd', -- purple
    -- replace = '#e06c75', -- red

    -- Others
    orange = '#e5c07b',
    branch = '#eea825'

}
local light = {
    bg = '#eff0eb',
    section_bg = '#5c6370',
    section_fg = '#eff0eb',
    fg = '#282a36',
    error = '#FC5C94',
    red = '#e05661',
    green = '#2DAE58',
    yellow = '#eea825',
    blue = '#118dc3',
    purple = '#9a77cf',
    gray = '#bebebe',

    -- mode colors
    NORMAL = '#2DAE58', -- green
    INSERT = '#118dc3', -- blue
    COMMAND = '#eea825', -- yellow
    VISUAL = '#9a77cf', -- purple
    REPLACE = '#e05661', -- red
    SELECT = '#2DAE58', -- green
    TERMINAL = '#2DAE58', -- green
    ['S-LINE'] = '#2DAE58', -- green
    ['V-LINE'] = '#2DAE58', -- green

    -- Others
    orange = '#e5c07b',
    branch = '#eea825'
}

-- More reference colors
-- local colors = {
--     bg = '#282c34',
--     fg = '#aab2bf',
--     section_bg = '#38393f',
--     lightbg = "#3C4048",
--     blue = '#61afef',
--     green = '#98c379',
--     purple = '#c678dd',
--     magenta = "#c678dd",
--     orange = '#e5c07b',
--     red = "#DF8890",
--     red1 = '#e06c75',
--     red2 = '#be5046',
--     yellow = '#e5c07b',
--     gray1 = '#5c6370',
--     gray2 = '#2c323d',
--     gray3 = '#3e4452',
--     darkgrey = '#5c6370',
--     grey = '#848586',
--     middlegrey = '#8791A5',
--     greenYel = "#EBCB8B",
--     darkblue = "#61afef",
--     cyan = "#22262C",
--     fg_green = "#65a380",
--     line_bg = "#282c34",
--     nord = "#81A1C1"
-- }

local settings = {
    bold = 1,
    italic = 1,
    bold_italic = 1
}

-- Local helper functions

-- Get LSP providers
function get_lsp()
    return function()
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
            return ' [None]'
        end
        local lsps = ' ['
        local n = 0
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                if n == 0 then
                    lsps = lsps .. client.name
                    n = n + 1
                else
                    lsps = lsps .. ' ' .. client.name
                    n = n + 1
                end
            end
        end
        return lsps .. '] '
    end
end

-- Return a closure function of the hex color
function color(val)
    return function()
        if vim.g.background ~= nil and vim.g.background == "light" then
            return light[val]
        else
            return dark[val]
        end
    end
end
-- Used to get a hex color
function get_color(val)
    if vim.g.background ~= nil and vim.g.background == "light" then
        return light[val]
    else
        return dark[val]
    end
end

function get_mode_info()
    local mode = vim.fn.mode()
    local alias = MODE_ALIASES[mode:byte()]
    local mode_color = color(alias)()
    return alias, mode_color
end

local buffer_not_empty = function()
    return not utils.is_buffer_empty()
end

local checkwidth = function()
    return utils.has_width_gt(35) and buffer_not_empty()
end

local function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value[1] == val then
            return true
        end
    end
    return false
end

function changes_to_diff()
    return (vcs.diff_add() ~= nil or vcs.diff_modified() ~= nil or vcs.diff_remove() ~= nil)
end
function has_lsp()
    return get_lsp() ~= nil
end
function has_git()
    return vcs.get_git_branch() ~= nil
end
function using_session()
    return (fn.ObsessionStatus() ~= nil)
end

local function file_readonly()
    if vim.bo.filetype == 'help' then
        return ''
    end
    if vim.bo.readonly == true then
        return '  '
    end
    return ''
end

local function get_current_file_name()
    local file = vim.fn.expand('%:t')
    if vim.fn.empty(file) == 1 then
        return ''
    end
    if string.len(file_readonly()) ~= 0 then
        return file .. file_readonly()
    end
    if vim.bo.modifiable then
        if vim.bo.modified then
            return file .. '  '
        end
    end
    return file .. ' '
end

local function mode_provider(provider_name, fg, bg)
    return function()
        local _, mode_color = get_mode_info()
        -- TODO: call highlight from utils normally
        if mode_color ~= nil then
            if fg then
                vim.api.nvim_command('hi Galaxy' .. provider_name .. ' guifg=' .. mode_color)
            end
            if bg then
                vim.api.nvim_command('hi Galaxy' .. provider_name .. ' guibg=' .. mode_color)
            end
        end
    end
end

-- local function trailing_whitespace()
--     local trail = vim.fn.search('\\s$', 'nw')
--     if trail ~= 0 then
--         return '  '
--     else
--         return nil
--     end
-- end

-- local function tab_indent()
--     local tab = vim.fn.search('^\\t', 'nw')
--     if tab ~= 0 then
--         return ' → '
--     else
--         return nil
--     end
-- end

-- local function buffers_count()
--     local buffers = {}
--     for _, val in ipairs(vim.fn.range(1, vim.fn.bufnr('$'))) do
--         if vim.fn.bufexists(val) == 1 and vim.fn.buflisted(val) == 1 then
--             table.insert(buffers, val)
--         end
--     end
--     return #buffers
-- end

local function git_condition()
    return utils.has_width_gt(45) and condition.buffer_not_empty() and condition.check_git_workspace()
    -- return condition.buffer_not_empty() and condition.check_git_workspace()
end

local function get_basename(file)
    return file:match("^.+/(.+)$")
end

local GetGitRoot = function()
    local git_dir = require('galaxyline.provider_vcs').get_git_dir()
    if not git_dir then
        return ''
    end

    local git_root = git_dir:gsub('/.git/?$', '')
    return get_basename(git_root)
end

-- Left side

gls.left = {{
    leftRounded = {
        provider = function()
            return ""
        end,
        highlight = {color('section_bg'), color('bg')}
    }
}, {
    SymbolMode = {
        provider = {mode_provider('SymbolMode', true, false), function()
            return '   '
        end},
        highlight = {color('bg'), color('section_bg')}
    }
}, {
    FileIcon = {
        provider = {function()
            return '  '
        end, 'FileIcon'},
        condition = condition.buffer_not_empty,
        highlight = {fileinfo.get_file_icon_color, color('section_bg')}
    }
}, {
    FileName = {
        provider = get_current_file_name,
        condition = condition.buffer_not_empty,
        highlight = {color('section_fg'), color('section_bg')}
        -- separator = '',
        -- separator_highlight = {color('section_bg'), color('bg')}
    }
}, {
    teech = {
        provider = function()
            return ""
        end,
        separator = " ",
        highlight = {color('section_bg'), color('bg')}
    }
}, {
    DiagnosticError = {
        provider = 'DiagnosticError',
        icon = '  ',
        highlight = {color('red'), color('bg')}
    }
}, {
    Space = {
        provider = function()
            return ' '
        end,
        highlight = {color('section_bg'), color('bg')}
    }
}, {
    DiagnosticWarn = {
        provider = 'DiagnosticWarn',
        icon = '  ',
        highlight = {color('orange'), color('bg')}
    }
}, {
    Space = {
        provider = function()
            return ' '
        end,
        highlight = {color('section_bg'), color('bg')}
    }
}, {
    DiagnosticInfo = {
        provider = 'DiagnosticInfo',
        icon = '  ',
        condition = condition.buffer_not_empty,
        highlight = {color('blue'), color('section_bg')},
        separator = ' ',
        separator_highlight = {color('section_bg'), color('bg')}
    }
}}

gls.mid = {{
    ShowLspClient = {
        provider = get_lsp(),
        condition = condition.check_active_lsp,
        icon = '  Lsp:',
        highlight = {color('fg'), color('bg')}
        -- seperator_highlight = {color('fg'), color('bg')}
    }
}, {
    DiffAdd = {
        provider = 'DiffAdd',
        condition = git_condition,
        icon = '  ',
        highlight = {color('green'), color('bg')}
    }
}, {
    DiffModified = {
        provider = 'DiffModified',
        condition = git_condition,
        icon = '  ',
        highlight = {color('orange'), color('bg')}
    }
}, {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = git_condition,
        icon = '  ',
        highlight = {color('red'), color('bg')}
    }
}, {
    GitRoot = {
        provider = {GetGitRoot, function()
            return ' '
        end},
        condition = git_condition,
        highlight = {color('fg'), color('bg')}
        -- separator_highlight = {color('fg'), color('bg')}
    }
}, {
    GitIcon = {
        provider = function()
            return '  '
        end,
        condition = git_condition,
        highlight = {color('red'), color('bg')}
    }
}, {
    GitBranch = {
        provider = 'GitBranch',
        condition = git_condition,
        highlight = {color('fg'), color('bg')}
    }
}}

gls.right = {{
    Vista = {
        provider = 'VistaPlugin',
        icon = ' Ⓕ '
    }
}, {
    LeftRound = {
        provider = {mode_provider('LeftRound', true), function()
            return ""
        end}
        -- highlight = {color('section_bg')}
    }
}, {
    ViMode = {
        provider = function()
            local alias, mode_color = get_mode_info()
            if alias ~= nil then
                if utils.has_width_gt(35) then
                    mode_name = alias
                else
                    mode_name = alias:sub(1, 1)
                end
            else
                mode_name = vim.fn.mode():byte()
            end

            if mode_color ~= nil then
                vim.api.nvim_command('hi GalaxyViMode guibg=' .. mode_color)
                vim.api.nvim_command('hi GalaxyViModeInv guifg=' .. mode_color)
            end
            return ' ' .. mode_name .. ' '
        end,
        highlight = {color('bg'), color('bg'), function()
            if settings.bold == 1 then
                return 'BOLD'
            end
        end}
    }
}, {
    FileInfo = {
        provider = {mode_provider('FileInfo', false, true), function()
            local fileEncode = fileinfo.get_file_encode()
            local fileFormat = fileinfo.get_file_format()

            return ' ' .. fileEncode:lower() .. ' ' .. fileFormat:lower() .. ' '
        end},
        highlight = {color('bg')}
    }
}, {
    Percent = {
        provider = {mode_provider('Percent', false, true), 'LinePercent'},
        separator = '',
        condition = condition.buffer_not_empty,
        highlight = {color('bg')}
    }
}, {
    RightRound = {
        provider = {mode_provider('RightRound', true), function()
            return ""
        end}
    }
}, {
    LineInfo = {
        provider = 'LineColumn',
        highlight = {color('fg'), color('bg')},
        separator = ' ',
        separator_highlight = {color('bg'), color('bg')}
    }
}}

-- Short status line

gls.short_line_left = {{
    FileIcon = {
        provider = {function()
            return '  '
        end, 'FileIcon'},
        condition = function()
            return buffer_not_empty and has_value(gl.short_line_list, vim.bo.filetype)
        end,
        highlight = {require('galaxyline.provider_fileinfo').get_file_icon,
                     require('galaxyline.provider_fileinfo').get_file_icon_color}
    }
}, {
    FileName = {
        provider = get_current_file_name,
        condition = buffer_not_empty,
        highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color, color('bg')}
        -- separator = '',
        -- separator_highlight = {color('section_bg'), color('bg')}
    }
}}

gls.short_line_right = {{
    BufferIcon = {
        provider = 'BufferIcon',
        highlight = {color('yellow'), color('section_bg')},
        separator = '',
        separator_highlight = {color('fg'), color('bg')}
    }
}}

-- Force manual load so that nvim boots with a status line
gl.load_galaxyline()
