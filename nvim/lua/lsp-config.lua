-- LSP Configuration
local lspconfig = require('lspconfig')

-- Configure diagnostics
vim.diagnostic.config({
  virtual_text = {
    prefix = '●',
    source = "always",
  },
  signs = true,
  underline = true,
  float = {
    source = "always",
    border = "rounded",
  },
})

-- BLOCCA COMPLETAMENTE pylsp in tutti i modi possibili
vim.g.lsp_settings_servers_dir = vim.fn.stdpath("data") .. "/lsp_servers"

-- Intercetta e blocca pylsp
local original_start_client = vim.lsp.start_client
vim.lsp.start_client = function(config)
  if config.name == "pylsp" or (config.cmd and config.cmd[1] and config.cmd[1]:match("pylsp")) then
    print("BLOCKED pylsp attempt!")
    return nil
  end
  return original_start_client(config)
end

-- SOLO Ruff LSP con 88 caratteri e E501 abilitato
lspconfig.ruff.setup({
  cmd = { "ruff", "server" },
  init_options = {
    settings = {
      ["line-length"] = 88,
      lint = {
        select = {"E", "F", "W", "E501"},
        args = {"--line-length=88", "--select=E,F,W,E501"}
      },
      format = {
        args = {"--line-length=88"}
      }
    }
  },
  settings = {
    ruff = {
      ["line-length"] = 88,
      lint = {
        select = {"E", "F", "W", "E501"},
        args = {"--line-length=88", "--select=E,F,W,E501"}
      },
      format = {
        args = {"--line-length=88"}
      }
    }
  }
})

-- LSP keymaps
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    print("LSP attached: " .. client.name)
    
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']g', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
  end,
})

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end
})
