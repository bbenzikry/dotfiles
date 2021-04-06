-- augroups / autocmds for file stuff
utils.create_augroups({
    setup = {{'BufWritePost', 'plugins.lua', 'PackerCompile'},
    -- Highlight text after yanking
             {'TextYankPost', '*', [[lua require('vim.highlight').on_yank({ higroup = 'Substitute', timeout = 200 })]]},
    -- Hide cursorline in insert mode
    --  {'InsertLeave,WinEnter', '*', 'set cursorline'}, {'InsertEnter,WinLeave', '*', 'set nocursorline'},
    -- Automatically close Vim if the quickfix window is the only one open
             {'WinEnter', '*', [[if winnr('$') == 1 && &buftype == 'quickfix' | q | endif]]},
    -- Automatically update changed file in Vim
    -- Triger `autoread` when files changes on disk
    -- https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
    -- https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
             {'FocusGained,BufEnter,CursorHold,CursorHoldI', '*', [[silent! if mode() != 'c' | checktime | endif]]},
    -- Notification after file change
    -- https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
             {'FileChangedShellPost', '*',
              [[echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None]]}},
    detect_filetypes = {{'BufRead,BufNewFile', 'Dockerfile-*', 'setfiletype dockerfile'},
                        {'BufRead,BufNewFile', '*.Dockerfile', 'setfiletype dockerfile'},

    -- gitconfig
                        {'BufRead,BufNewFile', '*config/git/config', 'setfiletype gitconfig'},
    -- graphql
                        {'BufRead,BufNewFile', '*.graphql', 'setfiletype graphql'},
                        {'BufRead,BufNewFile', '*.prisma', 'setfiletype graphql'},
    -- image
                        {'BufRead,BufNewFile', '*.png', 'setfiletype image'},
                        {'BufRead,BufNewFile', '*.jpg', 'setfiletype image'},
                        {'BufRead,BufNewFile', '*.jpeg', 'setfiletype image'},
                        {'BufRead,BufNewFile', '*.gif', 'setfiletype image'},
    -- json
                        {'BufRead,BufNewFile', '*.babelrc', 'setfiletype json'},
                        {'BufRead,BufNewFile', '.eslintrc', 'setfiletype json'},
                        {'BufRead,BufNewFile', '.prettierrc', 'setfiletype json'},
                        {'BufRead,BufNewFile', '.stylelintrc', 'setfiletype json'},
                        {'BufRead,BufNewFile', '.svgrrc', 'setfiletype json'},
    -- sh
                        {'BufRead,BufNewFile', '.env*', 'setfiletype sh'},
    -- yaml
                        {'BufRead,BufNewFile', '*.graphqlrc', 'setfiletype yaml'},
    -- zsh
                        {'BufRead,BufNewFile', 'zprofile', 'setfiletype zsh'},
                        {'BufRead,BufNewFile', '.zshrc', 'setfiletype zsh'}},
    -- Simple one-liner filetype specific things that I don't really want to put 
    -- into ftplugin files for whatever reason
    simple_filetypes = {{'FileType', 'typescriptreact', [[setlocal commentstring=//\ %s]]},
                        {'FileType', 'vue', [[setlocal commentstring=<!--\ %s\ -->]]},
    -- Open images automatically
                        {'FileType', 'image', [[lua require('common.filesystem').open_special_file()]]}}
})
