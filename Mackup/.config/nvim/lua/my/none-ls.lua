local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/code_actionslocal diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
  debug = false,
  sources = {
    formatting.prettierd.with({
      extra_filetypes = { "toml" },
    }),
    diagnostics.eslint_d,
    code_actions.eslint_d,

    formatting.stylua,

    diagnostics.flake8,
    formatting.black.with({ extra_args = { "--fast" } }),

    code_actions.shellcheck,
    diagnostics.shellcheck,
    formatting.shfmt,

    code_actions.gitsigns,
  },
})
