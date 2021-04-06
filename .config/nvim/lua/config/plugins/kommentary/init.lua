local M = {}

function M.config()
    -- print('in kommentary conf')
    local kommentary_config = require('kommentary.config')
    kommentary_config.configure_language('default', {
        single_line_comment_string = 'auto',
        prefer_single_line_comments = true,
        multi_line_comment_strings = false
    })
    kommentary_config.configure_language('typescriptreact', {
        single_line_comment_string = 'auto',
        prefer_single_line_comments = true
    })
    kommentary_config.configure_language('vue', {
        single_line_comment_string = 'auto',
        prefer_single_line_comments = true
    })
    kommentary_config.configure_language('css', {
        single_line_comment_string = 'auto',
        prefer_single_line_comments = true
    })
    kommentary_config.configure_language("lua", {
        single_line_comment_string = "--",
        prefer_single_line_comments = true
    })

end

return M
