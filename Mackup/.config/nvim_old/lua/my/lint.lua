return {
  "mfussenegger/nvim-lint",
  config = function()
    lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescript = { "eslint_d" },
      typescripttreact = { "eslint_d" },
      sh = { "shellcheck" },
      python = { "flake8" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
