-- https://neovim.io/doc/user/lua-guide.html

-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('my.plugins')
require('my.keymaps')
require('my.options')
require('my.cmp')
require('my.bufferline')
require('my.illuminate')
require('my.toggleterm')
require('my.none-ls');
require('my.project');

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- See `:help telescope` and `:help telescope.setup()`
require('my.telescope')
-- See `:help nvim-treesitter`
require('my.treesitter')

-- document existing key chains
require('which-key').register {
  ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
  ['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
  ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
}

vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#ffffff", bg = "#141a1f" })
vim.api.nvim_set_hl(0, "TelescopePreviewLine", { bg = "#615e3b" })
vim.api.nvim_set_hl(0, "Visual", { bg = "#615e3b" })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#203d32" })

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup()
require('mason-lspconfig').setup()

local servers = {
  cssls = {},
  html = {},
  tsserver = {},
  pyright = {},
  jsonls = {},
  yamlls = {},
  gopls = {},
  bashls = {},
  tailwindcss = {},
  svelte = {},
  templ = {},
  marksman = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'
mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}
mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = function()
        vim.api.nvim_exec_autocmds("User", { pattern = "LSPKeymaps" })
      end,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
