-- https://github.com/folke/lazy.nvim
-- :help lazy.nvim.txt
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'tpope/vim-fugitive',
  'tpope/vim-surround',
  'tpope/vim-repeat',
  'tpope/vim-sleuth',
  'mbbill/undotree',
  'windwp/nvim-autopairs',
  'moll/vim-bbye',
  'RRethy/vim-illuminate',
  'akinsho/toggleterm.nvim',
  'nvimtools/none-ls.nvim',
  'akinsho/bufferline.nvim',
  'epwalsh/obsidian.nvim',
  {
    'David-Kunz/jester',
    opts = {
      cmd = "npx jest test -t '$result' -- $file"
    }
  },
  require('my.mkdnflow'),
  require('my.telescope'),
  require('my.project'),
  require('my.gitsigns'),
  require('my.autoformat'),
  require('my.debug'),
  require('my.nvim-tree'),
  -- {
  --   "nvim-telescope/telescope-file-browser.nvim",
  --   dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  --   config = function() require("telescope").load_extension("file_browser") end,
  -- },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', tag = 'legacy', config = true },
      { 'folke/neodev.nvim', config = true },
    },
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'rafamadriz/friendly-snippets',
    },
  },
  { 'folke/which-key.nvim',  config = true },
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme 'gruvbox'
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    -- :help ibl
    main = 'ibl',
    config = true,
  },
  { 'numToStr/Comment.nvim', opts = {} },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  -- {
  --   'simrat39/rust-tools.nvim',
  --   opts = {
  --     -- server = {
  --     --   on_attach = function(_, bufnr)
  --     --     -- Hover actions
  --     --     vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
  --     --     -- Code action groups
  --     --     vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
  --     --   end,
  --     -- },
  --   }
  -- }
}, {})
