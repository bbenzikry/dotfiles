local buffer = {o, vim.bo}
local window = {o, vim.wo}
local opt = utils.opt

-- Uses https://github.com/antoinemadec/FixCursorHold.nvim - circumvents https://github.com/neovim/neovim/issues/12587
g.cursorhold_updatetime = 100

b.autoindent = true
b.expandtab = true -- Use spaces instead of tabs
b.shiftwidth = 2 -- Size of an indent
b.smartindent = true -- Insert indents automatically
b.softtabstop = 2 -- Number of spaces tabs count for
b.tabstop = 2 -- Number of spaces tabs count for

--  Autoformatting
opt('formatoptions', {'c', -- Auto-wrap comments
'a', -- Auto format paragraph
'2', -- Use the second line's indent vale when indenting (allows indented first line)
'q', -- Formatting comments with `gq`
'w', -- Trailing whitespace indicates a paragraph
'j', -- Remove comment leader when makes sense (joining lines)
'r', -- Insert comment leader after hitting Enter
'o' -- Insert comment leader after hitting `o` or `O`
}, buffer)

o.lazyredraw = true -- Redraw only when need to
o.backspace = [[indent,eol,start]]
o.clipboard = [[unnamed,unnamedplus]] -- Use the system clipboard
o.completeopt = [[menu,menuone,noselect]] -- Completion options for code completion
-- o.completeopt = [[menuone,noselect]] -- Completion options for code completion

o.encoding = 'UTF-8' -- Set the encoding type
o.hidden = true -- Enable modified buffers in background
o.history = 1000 -- Remember more stuff
o.hlsearch = true -- Highlight found searches
o.ignorecase = true -- Ignore case
o.incsearch = true -- Shows the match while typing
o.joinspaces = false -- No double spaces with join after a dot
o.scrolloff = 5 -- Set the cursor 5 lines down instead of directly at the top of the file
o.sidescrolloff = 8 -- Columns of context
o.shiftround = true -- Round indent
-- o.shortmess = o.shortmess .. "c" -- Do not show completion messages in command line e.g. "Pattern not found"
-- o.shortmess = o.shortmess .. "F" -- Do not show file info when editing a file, in the command line
-- o.shortmess = o.shortmess .. "W" -- Do not show "written" in command line when writing
-- o.shortmess = o.shortmess .. "I" -- Do not show intro message when starting Vim
o.showcmd = true -- Show me what I'm typing
o.showmatch = true -- Do not show matching brackets by flickering
o.showmode = false -- Do not show the mode in cmd
o.smartcase = true -- Don't ignore case with capitals
o.splitbelow = true -- Put new windows below current
o.splitright = true -- Put new windows right of current
o.termguicolors = true -- True color support
-- o.wildmode = 'list:longest' -- Command-line completion mode
-- o.wildmode = 'longest:full,full'
o.wildignore = [[**/node_modules/**', '**/coverage/**', '**/.idea/**', '**/.git/**', '**/.nuxt/**', "**/.metals/**"]] -- Ignore these files/folders
o.wildignorecase = true -- Ignore case when completing file names and directories

opt('colorcolumn', {81, 121}, window) -- Highlight columns
w.cursorline = false -- do not highlight current line

w.list = true -- Show some invisible characters like tabs etc
w.number = true -- Show line number
w.numberwidth = 2 -- Make the line number column thinner
w.relativenumber = true -- Show relative line numbers
w.signcolumn = 'yes:9' -- Show information next to the line numbers, allow up to 9 signs
w.wrap = false -- Disable line wrap
w.linebreak = true -- Break lines by spaces or tabs
o.showbreak = '↳ '

o.foldenable = true -- Enable folding
o.foldlevel = 0 -- Fold by default
o.modelines = 1 -- Only use folding settings for this file
o.foldmethod = 'marker' -- Fold based on markers as opposed to indentation

g.neoterm_autoinsert = 0 -- Do not start terminal in insert mode
g.neoterm_autoscroll = 1 -- Autoscroll the terminal

o.mouse = 'a' -- Enable mouse support
o.confirm = true -- Display a confirmation dialog when closing an unsaved file
o.updatetime = 2000 -- Trigger cursorhold faster ( note: cursorhold is now seperate and fires every 100ms )
o.inccommand = 'nosplit' -- Show preview of ex commands

-- Create any needed directories
local directories = {'.backup', '.undo', '.swap', '.session'}
for _, directory in ipairs(directories) do
    if fn.isdirectory(fn.stdpath('config') .. '/' .. directory) then
        cmd("call mkdir(stdpath('config') . '" .. directory .. "', 'p', 0700)")
    end
end

o.backup = true
o.writebackup = true
o.backupdir = fn.stdpath('config') .. '/.backup' -- Use backup files
o.directory = fn.stdpath('config') .. '/.swap' -- Use Swap files
o.undofile = true -- Maintain undo history between sessions
o.undolevels = 1000 -- Ensure we can undo...a lot
o.undoreload = 10000 -- Ensure we can undo...a lot
o.undodir = fn.stdpath('config') .. '/.undo' -- Set the undo directory
sessiondir = fn.stdpath('config') .. '/.session' -- Set the session directory
o.shada = '!,\'1000,<50,s10,h' -- Increase the shadafile size so that history is longer

-- Title
o.titlestring = "%t"
o.titleold = '%{fnamemodify(getcwd(), ":t")}'
o.title = true
o.titlelen = 70

-- o.guicursor = 'n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor,r-cr:hor20-Cursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175')

-- Search
opt('grepprg', 'rg --ignore-case --vimgrep')
opt('grepformat', '%f:%l:%c:%m,%f:%l:%m')

-- Binary
-- o.wildignore = {
--     "*.aux,*.out,*.toc",
--     "*.o,*.obj,*.dll,*.jar,*.pyc,__pycache__,*.rbc,*.class", -- media
--     "*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp",
--     "*.avi,*.m4a,*.mp3,*.oga,*.ogg,*.wav,*.webm", "*.eot,*.otf,*.ttf,*.woff",
--     "*.doc,*.pdf", -- archives
--     "*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz", -- temp/system
--     "*.*~,*~ ", "*.swp,.lock,.DS_Store,._*,tags.lock", -- version control
--     ".git,.svn"
-- }

opt('listchars', {'nbsp:⦸', -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
'tab:  ', 'extends:»', -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
'precedes:«', -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
'trail:·' -- Dot Operator (U+22C5)
}, window)
opt('fillchars', 'eob: ') -- Suppress ~ at EndOfBuffer

opt('whichwrap', 'b,s,h,l,<,>,[,]') -- Backspace and cursor keys wrap lines
opt('joinspaces', false) -- Prevent inserting two spaces with J

-- Messages
local short_mess = 'filnxtToOF'
short_mess = short_mess .. 'I' -- No splash screen
short_mess = short_mess .. 'W' -- Don't print "written" when editing
short_mess = short_mess .. 'a' -- Use abbreviations in messages ([RO] intead of [readonly])
short_mess = short_mess .. 'c' -- Do not show ins-completion-menu messages (match 1 of 2)
opt('shortmess', short_mess)

-- Navigation
-- opt('suffixesadd', '.md,.js,.ts,.tsx') -- File extensions not required when opening with `gf`

-- Load all specific settings
require('config._settings')
