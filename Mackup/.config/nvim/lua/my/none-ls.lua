return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    local formatting = null_ls.builtins.formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    local diagnostics = null_ls.builtins.diagnostics
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/code_actions
    local code_actions = null_ls.builtins.code_actions
    null_ls.setup({
      debug = false,
      sources = {
        -- javascript/typescript
        formatting.prettierd.with({
          extra_filetypes = { "toml" },
        }),
        diagnostics.eslint_d,
        code_actions.eslint_d,

        -- lua
        formatting.stylua,

        -- python
        diagnostics.flake8,
        formatting.black.with({ extra_args = { "--fast" } }),

        -- bash
        code_actions.shellcheck,
        diagnostics.shellcheck,
        formatting.shfmt,
      },
    })
  end,
}
