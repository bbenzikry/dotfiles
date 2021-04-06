local M = {}
function M.config()
    vim.g["conjure#highlight#enabled"] = 1
    vim.g["conjure#highlight#timeout"] = 500
    vim.g["conjure#highlight#group"] = "IncSearch"
    vim.g["conjure#mapping#doc_word"] = "K"
    vim.g["conjure#extract#tree_sitter#enabled"] = true
end
return M
