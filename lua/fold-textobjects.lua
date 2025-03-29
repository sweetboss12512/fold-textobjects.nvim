local M = {}

local get_fold_scope = function()
    local lnum = vim.fn.line(".")
    local start_line = vim.fn.foldclosed(lnum)
    local end_line = vim.fn.foldclosedend(lnum)

    if start_line < 0 then
        vim.cmd.foldclose({ mods = { silent = true, emsg_silent = true } })
        start_line = vim.fn.foldclosed(lnum)
        end_line = vim.fn.foldclosedend(lnum)
        vim.cmd.foldopen({ mods = { silent = true, emsg_silent = true } })
    end

    if start_line < 0 then
        return lnum, lnum
    end

    return start_line, end_line
end

local function set_linewise_selection(start_line, end_line)
    vim.cmd.normal({ "m`", bang = true })
    vim.api.nvim_win_set_cursor(0, { start_line, 0 })

    if vim.fn.mode() ~= "V" then
        vim.cmd.normal({ "V", bang = true })
    end

    vim.cmd.normal({ "o", bang = true })
    vim.api.nvim_win_set_cursor(0, { end_line, 0 })
end

function M.inside_fold()
    local start_line, end_line = get_fold_scope()

    if start_line == end_line then
        return
    end

    set_linewise_selection(start_line + 1, end_line)
end

function M.around_fold()
    local start_line, end_line = get_fold_scope()
    local buffer_end = vim.fn.line("$")

    -- Fix 'Cursor position outside buffer' error if the end_line is the last line of the buffer.
    if end_line == buffer_end then
        end_line = end_line - 1
    end

    if start_line == end_line then
        return
    end

    set_linewise_selection(start_line, end_line + 1)
end

return M
