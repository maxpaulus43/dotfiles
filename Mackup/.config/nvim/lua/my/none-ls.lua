-- https://github.com/nvimtools/none-ls-extras.nvim
-- https://github.com/gbprod/none-ls-php.nvim
-- https://github.com/gbprod/none-ls-shellcheck.nvim
-- https://github.com/gbprod/none-ls-luacheck.nvim
-- https://github.com/gbprod/none-ls-psalm.nvim
-- https://github.com/gbprod/none-ls-ecs.nvim

return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		-- https://git.sr.ht/~self/none-ls-extras.nvim/tree/main/item/lua/none-ls
		"nvimtools/none-ls-extras.nvim",
		"gbprod/none-ls-shellcheck.nvim",
	},
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
				require("none-ls.code_actions.eslint_d"),
				-- require("none-ls.diagnostics.eslint_d"),

				-- lua
				formatting.stylua,

				-- python
				require("none-ls.diagnostics.flake8"),
				formatting.black.with({ extra_args = { "--fast" } }),

				-- bash
				require("none-ls-shellcheck.diagnostics"),
				require("none-ls-shellcheck.code_actions"),
				formatting.shfmt,
			},
		})
	end,
}
