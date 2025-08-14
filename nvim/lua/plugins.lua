-- Plugin management with lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- GitHub Copilot
  {
    "github/copilot.vim",
    config = function()
      -- Keybinding per mettere i diagnostics nella quickfix list
      vim.keymap.set('n', ',tq', function()
        vim.diagnostic.setqflist()
        vim.cmd('copen')
      end, { desc = "Diagnostics in quickfix list" })
      -- Puoi aggiungere qui eventuali opzioni personalizzate

        -- Keybinding per mostrare tutte le shortcut personalizzate
        vim.keymap.set('n', ',ks', function()
          local shortcuts = {
            { key = ',tq', desc = 'Diagnostics in quickfix list' },
            { key = '<C-e>', desc = 'Toggle NeoTree' },
            { key = '<C-p>', desc = 'Find files (Telescope)' },
            { key = ',fg', desc = 'Live grep (Telescope)' },
            { key = ',fb', desc = 'Find buffers (Telescope)' },
            { key = ',fs', desc = 'Find document symbols (Telescope)' },
            { key = ',fS', desc = 'Find workspace symbols (Telescope)' },
            { key = ',fr', desc = 'Find references (Telescope)' },
            { key = ',xx', desc = 'Toggle diagnostics (Trouble)' },
            { key = ',xd', desc = 'Document diagnostics (Trouble)' },
            { key = ',xq', desc = 'Quickfix (Trouble)' },
            { key = ',xl', desc = 'Location list (Trouble)' },
            { key = 'gR', desc = 'LSP references (Trouble)' },
            { key = '<F8>', desc = 'Toggle diagnostics panel (Trouble)' },
            { key = ',tv', desc = 'Toggle virtual text inline' },
            { key = ',e', desc = 'Show diagnostic' },
            { key = '[d', desc = 'Previous diagnostic' },
            { key = ']d', desc = 'Next diagnostic' },
            { key = ',q', desc = 'Diagnostic quickfix' },
            { key = ',8', desc = 'Mostra tutti i diagnostici in una finestra' },
            { key = 'gd', desc = 'Vai alla definizione (LSP)' },
            { key = 'gD', desc = 'Vai alla dichiarazione (LSP)' },
            { key = 'gi', desc = 'Vai all\'implementazione (LSP)' },
            { key = 'K', desc = 'Hover (LSP)' },
            { key = '<C-k>', desc = 'Signature help (LSP)' },
            { key = ',wa', desc = 'Aggiungi workspace folder (LSP)' },
            { key = ',wr', desc = 'Rimuovi workspace folder (LSP)' },
            { key = ',wl', desc = 'Lista workspace folder (LSP)' },
            { key = ',D', desc = 'Vai al type definition (LSP)' },
            { key = ',rn', desc = 'Rename (LSP)' },
            { key = ',ca', desc = 'Code action (LSP)' },
            { key = 'gr', desc = 'References (LSP)' },
            { key = ',f', desc = 'Formatta buffer (LSP)' },
          }
          local lines = { 'Shortcut         Descrizione', '---------------- ------------------------------' }
          for _, s in ipairs(shortcuts) do
            table.insert(lines, string.format('%-15s %s', s.key, s.desc))
          end
          local buf = vim.api.nvim_create_buf(false, true)
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
          local win_height = math.min(25, #lines + 2)
          local win_width = 50
          local row = math.floor((vim.o.lines - win_height) / 2)
          local col = math.floor((vim.o.columns - win_width) / 2)
          vim.api.nvim_open_win(buf, true, {
            relative = 'editor',
            width = win_width,
            height = win_height,
            row = row,
            col = col,
            style = 'minimal',
            border = 'rounded',
            title = ' 📋 Shortcut personalizzate ',
            title_pos = 'center',
          })
          vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = buf, silent = true })
          vim.keymap.set('n', '<Esc>', '<cmd>close<cr>', { buffer = buf, silent = true })
        end, { desc = 'Elenca tutte le shortcut personalizzate' })
    end
  },
  -- Neo-tree file explorer con devicons pastel
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      -- Chiudi la quickfix list automaticamente quando si entra in un nuovo buffer
      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
          local buftype = vim.api.nvim_buf_get_option(0, 'buftype')
          if buftype ~= 'quickfix' then
            vim.cmd('cclose')
          end
        end,
      })
      require("neo-tree").setup({
        filesystem = {
          filtered_items = {
            visible = true,
          },
        },
        default_component_configs = {
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "",
            default = "",
            highlight = "NeoTreeFileIcon",
          },
        },
      })
      -- Pastel highlight per icone
      vim.api.nvim_set_hl(0, 'NeoTreeFileIcon', { fg = '#B3D1FF', ctermfg = 117 })
      vim.api.nvim_set_hl(0, 'NeoTreeDirectoryIcon', { fg = '#B3D1FF', ctermfg = 117 })
      vim.api.nvim_set_hl(0, 'NeoTreeDirectoryName', { fg = '#B3D1FF', ctermfg = 117 })
      vim.api.nvim_set_hl(0, 'NeoTreeExecFileIcon', { fg = '#B3FFB3', ctermfg = 121 })
      vim.api.nvim_set_hl(0, 'NeoTreeGitModified', { fg = '#FFB580', ctermfg = 215 })
      vim.api.nvim_set_hl(0, 'NeoTreeGitUntracked', { fg = '#FFB3B3', ctermfg = 217 })
      -- Keybinding globale Ctrl-e per toggle
      vim.keymap.set('n', '<C-e>', ':Neotree toggle<CR>', { desc = 'Toggle NeoTree' })
    end
  },

  -- Telescope per ricerca file (sostituisce fzf)
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('telescope').setup({
          defaults = {
            file_ignore_patterns = { "node_modules", ".git/" },
            hidden = false,
            -- Forza l'uso dei colori cterm nelle preview
            winblend = 0,
            color_devicons = false,
            preview = {
              treesitter = false, -- disabilita treesitter nella preview
            },
          },
          -- Forza highlight cterm per la preview
          highlight = {
            Normal = { ctermfg = 7, ctermbg = 0 },
            TelescopePreviewNormal = { ctermfg = 7, ctermbg = 0 },
          },
          -- Chiudi Trouble ogni volta che si entra in un nuovo buffer
          vim.api.nvim_create_autocmd("BufEnter", {
            callback = function()
              local ok, trouble = pcall(require, "trouble")
              if ok then trouble.close() end
            end,
          })
        })

      -- Ctrl-p per aprire file finder
      vim.keymap.set('n', '<C-p>', function()
        require('telescope.builtin').find_files()
      end, { desc = "Find files" })

      -- Altri keybinding utili
      vim.keymap.set('n', ',fg', function()
        require('telescope.builtin').live_grep()
      end, { desc = "Live grep" })

      vim.keymap.set('n', ',fb', function()
        require('telescope.builtin').buffers()
      end, { desc = "Find buffers" })

      -- Simboli e riferimenti
      vim.keymap.set('n', ',fs', function()
        require('telescope.builtin').lsp_document_symbols()
      end, { desc = "Find document symbols" })

      vim.keymap.set('n', ',fS', function()
        require('telescope.builtin').lsp_workspace_symbols()
      end, { desc = "Find workspace symbols" })

      vim.keymap.set('n', ',fr', function()
        require('telescope.builtin').lsp_references()
      end, { desc = "Find references" })
    end
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- Chiudi la Quickfix List ogni volta che selezioni una voce
      vim.api.nvim_create_autocmd("QuickFixCmdPost", {
        callback = function()
          vim.cmd('cclose')
        end,
      })
      -- Chiudi la Quickfix List quando entri in un buffer che non è quickfix
      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
          local buftype = vim.api.nvim_buf_get_option(0, 'buftype')
          if buftype ~= 'quickfix' then
            vim.cmd('cclose')
          end
        end,
      })
      -- Chiudi la Quickfix List quando entri in una finestra che non è quickfix
      vim.api.nvim_create_autocmd("WinEnter", {
        callback = function()
          local buftype = vim.api.nvim_buf_get_option(0, 'buftype')
          if buftype ~= 'quickfix' then
            vim.cmd('cclose')
          end
        end,
      })
      -- ...qui puoi reinserire tutta la tua configurazione LSP...
    end
  },

  -- Mason for LSP server management
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },

  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "ruff", "pyright", "ts_ls", "lua_ls" },
      })
    end
  },

  -- Autocompletamento
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        })
      })
    end
  },

  -- Treesitter per syntax highlighting avanzato (TEMPORANEAMENTE DISABILITATO PER DESERT)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { "python", "javascript", "typescript", "lua", "vim", "json" },
        auto_install = true,
        highlight = {
          enable = false, -- DISABILITATO per evitare conflitti con tema desert
          additional_vim_regex_highlighting = true, -- Usa highlighting tradizionale
        },
        indent = {
          enable = true
        }
      })
    end
  },

  -- Trouble per diagnostica e riferimenti
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup({
        position = "bottom", -- bottom, top, left, right
        height = 10, -- height of the trouble list when position is top or bottom
        width = 50, -- width of the list when position is left or right
        icons = true, -- use devicons for filenames
        mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
        fold_open = "", -- icon used for open folds
        fold_closed = "", -- icon used for closed folds
        group = true, -- group results by file
        padding = true, -- add an extra new line on top of the list
        action_keys = { -- key mappings for actions in the trouble list
          close = "q", -- close the list
          cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
          refresh = "r", -- manually refresh
          jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
          open_split = { "<c-x>" }, -- open buffer in new split
          open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
          open_tab = { "<c-t>" }, -- open buffer in new tab
          jump_close = {"o"}, -- jump to the diagnostic and close the list
          toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
          toggle_preview = "P", -- toggle auto_preview
          hover = "K", -- opens a small popup with the full multiline message
          preview = "p", -- preview the diagnostic location
          close_folds = {"zM", "zm"}, -- close all folds
          open_folds = {"zR", "zr"}, -- open all folds
          toggle_fold = {"zA", "za"}, -- toggle fold of current file
          previous = "k", -- previous item
          next = "j" -- next item
        },
        indent_lines = true, -- add an indent guide below the fold icons
        auto_open = false, -- automatically open the list when you have diagnostics
        auto_close = false, -- automatically close the list when you have no diagnostics
        auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
        auto_fold = false, -- automatically fold a file trouble list at creation
        auto_jump = {"lsp_definitions"}, -- for the given modes, automatically jump if there is only a single result
        signs = {
          -- icons / text used for a diagnostic
          error = "",
          warning = "",
          hint = "",
          information = "",
          other = "﫠"
        },
        use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
      })

      -- Keybindings per trouble - più intuitivi per vedere errori
      vim.keymap.set("n", ",xx", function() require("trouble").toggle("workspace_diagnostics") end, { desc = "Toggle diagnostics" })
      vim.keymap.set("n", ",xd", function() require("trouble").toggle("document_diagnostics") end, { desc = "Document diagnostics" })
      vim.keymap.set("n", ",xq", function() require("trouble").toggle("quickfix") end, { desc = "Quickfix" })
      vim.keymap.set("n", ",xl", function() require("trouble").toggle("loclist") end, { desc = "Location list" })
      vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end, { desc = "LSP references" })

      -- Shortcut veloce per aprire/chiudere diagnostici
      vim.keymap.set("n", "<F8>", function() require("trouble").toggle("workspace_diagnostics") end, { desc = "Toggle diagnostics panel" })
    end
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    config = function()
        -- Stato del toggle per i virtual text
        local virtual_text_enabled = false

        -- Funzione per applicare la configurazione dei diagnostici
        local function apply_diagnostic_config()
          vim.diagnostic.config({
            virtual_text = virtual_text_enabled,
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
            float = {
              border = 'rounded',
              source = 'always',
              header = '',
              prefix = '',
            },
          })
        end

        -- Applica la configurazione iniziale (virtual_text disabilitato)
        vim.api.nvim_create_autocmd('VimEnter', {
          callback = function()
            virtual_text_enabled = false
            apply_diagnostic_config()
          end,
        })
          -- Chiudi la Quickfix List ogni volta che selezioni una voce
          vim.api.nvim_create_autocmd("QuickFixCmdPost", {
            callback = function()
              vim.cmd('cclose')
            end,
          })

      -- Keybinding per il toggle
      vim.keymap.set("n", ",tv", function()
        virtual_text_enabled = not virtual_text_enabled
        apply_diagnostic_config()
        if virtual_text_enabled then
          print("✅ Virtual text ENABLED")
        else
          print("❌ Virtual text DISABLED")
        end
      end, { desc = "Toggle virtual text inline (,tv)" })

      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Configurazione LSP servers
      lspconfig.pyright.setup({
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
            }
          }
        }
      })

      lspconfig.ts_ls.setup({
        capabilities = capabilities,
      })

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = {'vim'} },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
          },
        },
      })

      -- Keybindings per diagnostici
      vim.keymap.set('n', ',e', vim.diagnostic.open_float, { desc = "Show diagnostic" })
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Next diagnostic" })
      vim.keymap.set('n', ',q', vim.diagnostic.setloclist, { desc = "Diagnostic quickfix" })

      -- Finestra popup con tutti gli errori
      vim.keymap.set("n", ",8", function()
        local diagnostics = vim.diagnostic.get(0) -- 0 = buffer corrente
        if #diagnostics == 0 then
          print("✅ Nessun errore in questo file!")
          return
        end

        local lines = {}
        for i, diag in ipairs(diagnostics) do
          local severity_icon = (diag.severity == 1 and "") or (diag.severity == 2 and "") or ""
          local severity_text = (diag.severity == 1 and "ERROR") or (diag.severity == 2 and "WARNING") or "INFO"
          local line_content = vim.api.nvim_buf_get_lines(0, diag.lnum, diag.lnum + 1, false)[1] or ""

          table.insert(lines, string.format("%s %s [Linea %d]", severity_icon, severity_text, diag.lnum + 1))
          -- CORREZIONE: Gestisce i messaggi di errore su più righe
          for _, msg_line in ipairs(vim.split(diag.message, "\n")) do
            table.insert(lines, "  " .. msg_line)
          end
          table.insert(lines, "    └─ " .. vim.trim(line_content))
          table.insert(lines, "") -- Spazio tra gli errori
        end

        -- Mostra in popup
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

        -- CORREZIONE: Calcola dimensioni e posizione per centrare la finestra
        local win_height = math.min(25, #lines + 2)
        local win_width = math.min(100, vim.o.columns - 4)
        local row = math.floor((vim.o.lines - win_height) / 2)
        local col = math.floor((vim.o.columns - win_width) / 2)

        vim.api.nvim_open_win(buf, true, {
          relative = 'editor',
          width = win_width,
          height = win_height,
          row = row,
          col = col,
          style = 'minimal',
          border = 'rounded',
          title = " 🚨 Diagnostici del file (" .. #diagnostics .. ") ",
          title_pos = 'center',
        })

        -- Esci con 'q' o Esc
        vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = buf, silent = true })
        vim.keymap.set('n', '<Esc>', '<cmd>close<cr>', { buffer = buf, silent = true })
      end, { desc = "Mostra tutti i diagnostici in una finestra (,8)" })

      -- Keybindings LSP
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Applica di nuovo la config all'attach per sicurezza
          apply_diagnostic_config()

          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', function()
            -- Chiudi tutte le finestre Trouble
            for _, win in ipairs(vim.api.nvim_list_wins()) do
              local buf = vim.api.nvim_win_get_buf(win)
              local name = vim.api.nvim_buf_get_name(buf)
              if name:match('Trouble') then
                vim.api.nvim_win_close(win, true)
              end
            end
            vim.lsp.buf.definition()
            -- Chiudi la Quickfix List se è aperta (subito dopo il salto)
            vim.defer_fn(function()
              vim.cmd('cclose')
            end, 50)
          end, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', ',wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', ',wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', ',wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set('n', ',D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', ',rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, ',ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', ',f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })
    end
  },

  -- FORZA TEMA DESERT - configurazione prioritaria
  {
    "desert-theme-force",
    dir = vim.fn.stdpath("config"),
    priority = 1000, -- Massima priorità
    config = function()
      -- Forza disabilitazione true colors
      vim.opt.termguicolors = false

      -- Applica il tema desert
      vim.cmd("colorscheme desert")

      -- Autocmd per riapplicare desert se viene cambiato
      vim.api.nvim_create_autocmd({"VimEnter", "ColorScheme"}, {
        pattern = "*",
        callback = function()
          if vim.g.colors_name ~= "desert" then
            vim.cmd("colorscheme desert")
          end
          -- Assicurati che termguicolors rimanga disabilitato
          vim.opt.termguicolors = false
        end,
      })

      print("🏜️ Tema DESERT forzato!")
    end
  }
})

