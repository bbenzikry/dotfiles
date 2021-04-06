-- TODO: change to snazzy colors
local M = {}
function M.config()
    vim.cmd [[packadd nvim-web-devicons]]
    require"nvim-web-devicons".setup {
        override = {
            ["htm"] = {
                icon = "",
                name = "Htm"
            },
            ["html"] = {
                icon = "",
                name = "html"
            },
            ["jpeg"] = {
                icon = " ",
                color = "#BD77DC",
                name = "jpeg"
            },
            ["jpg"] = {
                icon = " ",
                color = "#BD77DC",
                name = "jpg"
            },
            ["js"] = {
                icon = "",
                color = "#EBCB8B",
                name = "js"
            },
            ["png"] = {
                icon = " ",
                color = "#BD77DC",
                name = "png"
            },
            ["webp"] = {
                icon = " ",
                color = "#a074c4",
                name = "Webp"
            },
            ["mp3"] = {
                icon = "",
                color = "#C8CCD4",
                name = "mp3"
            },
            ["mp4"] = {
                icon = "",
                color = "#C8CCD4",
                name = "mp4"
            },
            ["out"] = {
                icon = "",
                color = "#C8CCD4",
                name = "out"
            },
            ["lock"] = {
                icon = "",
                color = "#DE6B74",
                name = "lock"
            },
            ["zip"] = {
                icon = "",
                color = "#EBCB8B",
                name = "zip"
            },
            ["xz"] = {
                icon = "",
                color = "#EBCB8B",
                name = "xz"
            },
            ["ts"] = {
                icon = "ﯤ",
                color = "#519ABA",
                name = "ts"
            },
            ["Makefile"] = {
                icon = ""
            },
            ["sass"] = {
                icon = ""
            },
            ["scss"] = {
                icon = ""
            }
        }
        -- default = true
    }
end
return M
