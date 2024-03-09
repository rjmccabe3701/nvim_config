local map = vim.api.nvim_set_keymap
default_options = {noremap = true, silent = true}
expr_options = {noremap = true, expr = true, silent = true}

-- hack for microsoft terminal
vim.cmd("command! Vblock normal! <C-v>")
map("n", "tv", ":Vblock<CR>", default_options)

-- map the leader key
--map("n", "<Space>", "<NOP>", default_options)
--map("n", "<Up>", "<NOP>", default_options)
--map("n", "<Down>", "<NOP>", default_options)
--map("n", "<Left>", "<NOP>", default_options)
--map("n", "<Right>", "<NOP>", default_options)
--vim.g.mapleader = " "

-- center search results
map("n", "n", "nzz", default_options)
map("n", "N", "Nzz", default_options)

-- Deal with visual line wraps
map("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_options)
map("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_options)

-- better indenting
map("v", "<", "<gv", default_options)
map("v", ">", ">gv", default_options)

-- paste over currently selected text without yanking it
map("v", "p", "\"_dP", default_options)

-- Cancel search highlighting with ESC
map("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", default_options)

-- Switch tab
map("n", "<C-Left>", ":tabprevious<CR>", default_options)
map("n", "<C-Right>", ":tabnext<CR>", default_options)

-- Autocorrect spelling from previous error
map("i", "<c-f>", "<c-g>u<Esc>[s1z=`]a<c-g>u", default_options)

-- Move selected line / block of text in visual mode
map("x", "K", ":move '<-2<CR>gv-gv", default_options)
map("x", "J", ":move '>+1<CR>gv-gv", default_options)

-- starlite mappings
map("n", "*", "<cmd>lua require'starlite'.star()<CR>", default_options)
map("n", "g*", "<cmd>lua require'starlite'.g_star()<CR>", default_options)
map("n", "#", "<cmd>lua require'starlite'.hash()<CR>", default_options)
map("n", "g#", "<cmd>lua require'starlite'.g_hash()<CR>", default_options)

function EscapePair()
    local closers = {")", "]", "}", ">", "'", "\"", "`", ","}
    local line = vim.api.nvim_get_current_line()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local after = line:sub(col + 1, -1)
    local closer_col = #after + 1
    local closer_i = nil
    for i, closer in ipairs(closers) do
        local cur_index, _ = after:find(closer)
        if cur_index and (cur_index < closer_col) then
            closer_col = cur_index
            closer_i = i
        end
    end
    if closer_i then
        vim.api.nvim_win_set_cursor(0, {row, col + closer_col})
    else
        vim.api.nvim_win_set_cursor(0, {row, col + 1})
    end
end

map("i", "<C-l>", "<cmd>lua EscapePair()<CR>", default_options)

function git_lines_history()
	local start_row, start_col = unpack(vim.api.nvim_buf_get_mark(0, '<'))
	local end_row, end_col = unpack(vim.api.nvim_buf_get_mark(0, '>'))
	vim.api.nvim_command(string.format("vertical Git log --oneline --no-patch -L%d,%d:%%", start_row, end_row))
end

map("v", "x", ":lua git_lines_history()<CR>", default_options)

-- don't paste in select mode when press 'p'
map("s", "p", "p", default_options)

function open_help()
	local cword = vim.fn.expand('<cword>')
	vim.cmd("h " .. cword)
end

map("n", "<C-h>", "<cmd>lua open_help()<CR>", default_options)

-- vim.keymap.set("n", ",e", function()
--    vim.print('hello')
--    end)
vim.keymap.set("n", ",e", function()
   vim.cmd('e ' .. vim.fn.expand('%:p:h'))
   end)
vim.keymap.set("n", ",t", function()
   vim.cmd('tabe ' .. vim.fn.expand('%:p:h'))
   end)
vim.keymap.set("n", ",s", function()
   vim.cmd('split ' .. vim.fn.expand('%:p:h'))
   end)

