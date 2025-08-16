-- Michele Angrisano's Neovim configuration file. 2025

-- Basic settings
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.showmode = false
vim.opt.wildmenu = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.cursorline = true
vim.opt.autoindent = true
vim.opt.ruler = true
vim.opt.relativenumber = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.wrap = false
vim.opt.mouse = "a"
vim.opt.tabstop = 4
vim.opt.updatetime = 500
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.laststatus = 2
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.background = "dark"


-- Key mappings
vim.g.mapleader = ","

-- Tab navigation
vim.keymap.set('n', '<C-Left>', ':tabprevious<CR>')
vim.keymap.set('n', '<C-Right>', ':tabnext<CR>')
vim.keymap.set('n', '<C-j>', ':tabprevious<CR>')
vim.keymap.set('n', '<C-k>', ':tabnext<CR>')

-- Escape with jj
vim.keymap.set('i', 'jj', '<Esc>')

-- Remove trailing spaces on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    command = "%s/\\s\\+$//e"
})

-- Python specific settings
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.opt_local.textwidth = 88
        vim.opt_local.colorcolumn = "89"
    end
})

-- Colorscheme
vim.cmd('colorscheme desert')
-- Evidenziazione Visual Mode: giallo compatibile con GUI e terminale
-- Evidenziazione Visual Mode: blu pastello neutro, uniforme con il tema
vim.api.nvim_set_hl(0, 'Visual', { bg = '#E3F2FD', ctermbg = 195 })

-- Load plugins and LSP
require("plugins")
require("lsp-config")

-- Fix background uniformity (like in .vimrc)
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        vim.cmd('highlight NonText ctermfg=NONE guifg=NONE')
        vim.cmd('highlight EndOfBuffer ctermfg=NONE guifg=NONE')
    end
})

-- Apply highlights immediately
vim.cmd('highlight NonText ctermfg=NONE guifg=NONE')
vim.cmd('highlight EndOfBuffer ctermfg=NONE guifg=NONE')


-- Highlight trailing whitespace in red (versione migliorata)
vim.api.nvim_set_hl(0, 'ExtraWhitespace', { bg = '#ff5f5f' })

-- Autocommand per evidenziare trailing whitespace
vim.api.nvim_create_augroup('TrailingWhitespace', { clear = true })
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'BufRead', 'BufNewFile' }, {
    group = 'TrailingWhitespace',
    pattern = '*',
    callback = function()
        vim.fn.matchadd('ExtraWhitespace', [[\s\+$]])
    end
})

-- Custom statusline colors (from .vimrc lines 213-217)
-- Rimuovo override Visual Mode
vim.api.nvim_set_hl(0, 'StatuslineRed', { fg = 'red', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'StatuslinePastelRed', { fg = '#FFB3B3', bg = 'NONE', ctermfg = 217, ctermbg = 0 })
vim.api.nvim_set_hl(0, 'StatuslinePastelBlue', { fg = '#E3F2FD', bg = 'NONE', ctermfg = 195, ctermbg = 0 })
vim.api.nvim_set_hl(0, 'StatuslinePastelGreen', { fg = '#B3FFB3', bg = 'NONE', ctermfg = 121, ctermbg = 0 })
vim.api.nvim_set_hl(0, 'StatuslinePastelOrange', { fg = '#FFB580', bg = 'NONE' })

-- Custom statusline (from .vimrc lines 78-87)
vim.opt.statusline = ''
    .. '%#StatusLine# %n %*'                        -- buffer number in bianco, formato originale
    .. '%#StatusLine#%{&ff}%*'                      -- file format in bianco
    .. '%#StatuslinePastelRed#%y%* '                -- file type in rosso pastello
    .. '%#StatuslinePastelBlue#%<%F%*'             -- full file path in blu pastello
    .. '%2*%m%*'                                   -- modified flag
    .. '%#StatusLine#%=%l%*'                        -- current line in bianco (right aligned)
    .. '%#StatuslinePastelRed#/%L%*'                -- total lines in rosso pastello
    .. '%1*%4v %*'                                 -- virtual column number
    .. '%#StatuslinePastelGreen#0x%04B%*'          -- character under cursor in verde pastello

-- Fix statusline background uniformity
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
    -- Rendi trasparenti tutti i gruppi di highlight della statusline
    vim.api.nvim_set_hl(0, 'User1', { fg = '#ffffff', bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'User2', { fg = '#FFB580', bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'User3', { fg = '#00ff00', bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'User4', { fg = '#4682b4', bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'User5', { fg = '#ffffff', bg = 'NONE' })
    -- Statusline principale
    vim.api.nvim_set_hl(0, 'StatusLine', { fg = '#ffffff', bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = '#808080', bg = 'NONE' })
    end
})

-- Applica immediatamente
vim.api.nvim_set_hl(0, 'User1', { fg = '#ffffff', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'User2', { fg = '#FFB580', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'User3', { fg = '#00ff00', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'User4', { fg = '#4682b4', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'User5', { fg = '#ffffff', bg = 'NONE' })
-- Solo una definizione, per evitare override
vim.api.nvim_set_hl(0, 'StatusLine', { fg = '#ffffff', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = '#808080', bg = 'NONE' })

-- CORREZIONE COLORI DESERT PER GHOSTTY
-- Configurazione colori compatibile con Neovim
vim.env.TERM = "xterm-256color"
-- Ripristina colori statusline compatibili con 256 colori
    vim.cmd('highlight StatusLine ctermfg=15 ctermbg=0')
    vim.cmd('highlight StatusLineNC ctermfg=8 ctermbg=0')
vim.cmd('highlight User1 ctermfg=15 ctermbg=0')
vim.cmd('highlight User2 ctermfg=11 ctermbg=0')
vim.cmd('highlight User3 ctermfg=10 ctermbg=0')
vim.cmd('highlight User4 ctermfg=12 ctermbg=0')
vim.cmd('highlight User5 ctermfg=15 ctermbg=0')
-- Colori statusline stile pastel/desert
vim.cmd('highlight StatusLine ctermfg=15 ctermbg=0')
vim.cmd('highlight StatusLineNC ctermfg=8 ctermbg=0')
vim.cmd('highlight User1 ctermfg=15 ctermbg=0')
vim.cmd('highlight User2 ctermfg=11 ctermbg=0')
vim.cmd('highlight User3 ctermfg=10 ctermbg=0')
vim.cmd('highlight User4 ctermfg=12 ctermbg=0')
vim.cmd('highlight User5 ctermfg=15 ctermbg=0')
vim.cmd('highlight StatusLine ctermfg=15 ctermbg=0')
vim.cmd('highlight StatusLineNC ctermfg=8 ctermbg=0')
vim.cmd('highlight User5 ctermfg=15 ctermbg=0')
vim.cmd('highlight User1 ctermfg=217 ctermbg=0') -- rosso pastello (unix)
vim.cmd('highlight User2 ctermfg=215 ctermbg=0') -- arancione pastello ([python])



vim.api.nvim_set_hl(0, 'Visual', { bg = '#5f5f5f', ctermbg = 59 })

