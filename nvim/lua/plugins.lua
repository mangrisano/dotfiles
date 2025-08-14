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
  -- Keybinding to put diagnostics in the quickfix list
      vim.keymap.set('n', ',tq', function()
        vim.diagnostic.setqflist()
        vim.cmd('copen')
      end, { desc = "Diagnostics in quickfix list" })
  -- You can add custom options here

  -- Keybinding to show all custom shortcuts
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
            { key = ',8', desc = 'Show all diagnostics in a window' },
            { key = 'gd', desc = 'Go to definition (LSP)' },
            { key = 'gD', desc = 'Go to declaration (LSP)' },
            { key = 'gi', desc = 'Go to implementation (LSP)' },
            { key = 'K', desc = 'Hover (LSP)' },
            { key = '<C-k>', desc = 'Signature help (LSP)' },
            { key = ',wa', desc = 'Add workspace folder (LSP)' },
            { key = ',wr', desc = 'Remove workspace folder (LSP)' },
            { key = ',wl', desc = 'List workspace folders (LSP)' },
            { key = ',D', desc = 'Go to type definition (LSP)' },
            { key = ',rn', desc = 'Rename (LSP)' },
            { key = ',ca', desc = 'Code action (LSP)' },
            { key = 'gr', desc = 'References (LSP)' },
            { key = ',f', desc = 'Formatta buffer (LSP)' },
          }
          local lines = { 'Shortcut         Description', '---------------- ------------------------------' }
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
            title = ' 📋 Custom Shortcuts ',
            title_pos = 'center',
          })
          vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = buf, silent = true })
          vim.keymap.set('n', '<Esc>', '<cmd>close<cr>', { buffer = buf, silent = true })
  end, { desc = 'List all custom shortcuts' })
    end
  },
  -- Neo-tree file explorer with pastel devicons
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
  -- Automatically close the quickfix list when entering a new buffer
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

  -- Telescope for file search (replaces fzf)
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('telescope').setup({
          defaults = {
            file_ignore_patterns = { "node_modules", ".git/" },
            hidden = false,
            -- Force cterm colors in previews
            winblend = 0,
            color_devicons = false,
            preview = {
              treesitter = false, -- disable treesitter in preview
            },
          },
          -- Force cterm highlight for preview
          highlight = {
            Normal = { ctermfg = 7, ctermbg = 0 },
            TelescopePreviewNormal = { ctermfg = 7, ctermbg = 0 },
          },
          -- Close Trouble every time you enter a new buffer
          vim.api.nvim_create_autocmd("BufEnter", {
            callback = function()
              local ok, trouble = pcall(require, "trouble")
              if ok then trouble.close() end
            end,
          })
        })

  -- Ctrl-p to open file finder
      vim.keymap.set('n', '<C-p>', function()
        require('telescope.builtin').find_files()
      end, { desc = "Find files" })

  -- Other useful keybindings
      vim.keymap.set('n', ',fg', function()
        require('telescope.builtin').live_grep()
      end, { desc = "Live grep" })

      vim.keymap.set('n', ',fb', function()
        require('telescope.builtin').buffers()
      end, { desc = "Find buffers" })

  -- Symbols and references
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
  -- Close the Quickfix List every time you select an entry
      vim.api.nvim_create_autocmd("QuickFixCmdPost", {
        callback = function()
          vim.cmd('cclose')
        end,
      })
  -- Close the Quickfix List when entering a buffer that is not quickfix
      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
          local buftype = vim.api.nvim_buf_get_option(0, 'buftype')
          if buftype ~= 'quickfix' then
            vim.cmd('cclose')
          end
        end,
      })
  -- Close the Quickfix List when entering a window that is not quickfix
      vim.api.nvim_create_autocmd("WinEnter", {
        callback = function()
          local buftype = vim.api.nvim_buf_get_option(0, 'buftype')
          if buftype ~= 'quickfix' then
            vim.cmd('cclose')
          end
        end,
      })
  -- ...here you can reinsert all your LSP configuration...
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

  -- Autocompletion
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

  -- Treesitter for advanced syntax highlighting (TEMPORARILY DISABLED FOR DESERT)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { "python", "javascript", "typescript", "lua", "vim", "json" },
        auto_install = true,
        highlight = {
          enable = false, -- DISABLED to avoid conflicts with desert theme
          additional_vim_regex_highlighting = true, -- Use traditional highlighting
        },
        indent = {
          enable = true
        }
      })
    end
  },

  -- Trouble for diagnostics and references
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

  -- Keybindings for trouble - more intuitive to see errors
      vim.keymap.set("n", ",xx", function() require("trouble").toggle("workspace_diagnostics") end, { desc = "Toggle diagnostics" })
      vim.keymap.set("n", ",xd", function() require("trouble").toggle("document_diagnostics") end, { desc = "Document diagnostics" })
      vim.keymap.set("n", ",xq", function() require("trouble").toggle("quickfix") end, { desc = "Quickfix" })
      vim.keymap.set("n", ",xl", function() require("trouble").toggle("loclist") end, { desc = "Location list" })
      vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end, { desc = "LSP references" })

  -- Quick shortcut to open/close diagnostics
      vim.keymap.set("n", "<F8>", function() require("trouble").toggle("workspace_diagnostics") end, { desc = "Toggle diagnostics panel" })
    end
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    config = function()
  -- Toggle state for virtual text
        local virtual_text_enabled = false

  -- Function to apply diagnostic configuration
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

  -- Apply initial configuration (virtual_text disabled)
        vim.api.nvim_create_autocmd('VimEnter', {
          callback = function()
            virtual_text_enabled = false
            apply_diagnostic_config()
          end,
        })
          -- Close the Quickfix List every time you select an entry
          vim.api.nvim_create_autocmd("QuickFixCmdPost", {
            callback = function()
              vim.cmd('cclose')
            end,
          })

  -- Keybinding for toggle
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

  -- LSP servers configuration
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

  -- Keybindings for diagnostics
      vim.keymap.set('n', ',e', vim.diagnostic.open_float, { desc = "Show diagnostic" })
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Next diagnostic" })
      vim.keymap.set('n', ',q', vim.diagnostic.setloclist, { desc = "Diagnostic quickfix" })

  -- Popup window with all errors
      vim.keymap.set("n", ",8", function()
        local diagnostics = vim.diagnostic.get(0) -- 0 = buffer corrente
        if #diagnostics == 0 then
          print("✅ No errors in this file!")
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

  -- Show in popup
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- FIX: Calculate size and position to center the window
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
          title = " 🚨 File Diagnostics (" .. #diagnostics .. ") ",
          title_pos = 'center',
        })

  -- Exit with 'q' or Esc
        vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = buf, silent = true })
        vim.keymap.set('n', '<Esc>', '<cmd>close<cr>', { buffer = buf, silent = true })
  end, { desc = "Show all diagnostics in a window (,8)" })

  -- LSP Keybindings
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Reapply config on attach for safety
          apply_diagnostic_config()

          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', function()
            -- Close all Trouble windows
            for _, win in ipairs(vim.api.nvim_list_wins()) do
              local buf = vim.api.nvim_win_get_buf(win)
              local name = vim.api.nvim_buf_get_name(buf)
              if name:match('Trouble') then
                vim.api.nvim_win_close(win, true)
              end
            end
            vim.lsp.buf.definition()
            -- Close the Quickfix List if open (right after jump)
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

  -- FORCE DESERT THEME - priority configuration
  {
    "desert-theme-force",
    dir = vim.fn.stdpath("config"),
  priority = 1000, -- Highest priority
    config = function()
  -- Force disable true colors
      vim.opt.termguicolors = false

  -- Apply desert theme
      vim.cmd("colorscheme desert")

  -- Autocmd to reapply desert if changed
      vim.api.nvim_create_autocmd({"VimEnter", "ColorScheme"}, {
        pattern = "*",
        callback = function()
          if vim.g.colors_name ~= "desert" then
            vim.cmd("colorscheme desert")
          end
          -- Make sure termguicolors stays disabled
          vim.opt.termguicolors = false
        end,
      })

  print("🏜️ DESERT theme forced!")
    end
  }
})

