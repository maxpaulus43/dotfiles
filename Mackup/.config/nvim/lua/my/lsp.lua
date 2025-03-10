-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require("mason").setup()
require("mason-lspconfig").setup()
local lspconfig = require("lspconfig")

local servers = {
	cssls = {},
	html = {},
	ts_ls = {},
	pyright = {},
	jsonls = {},
	yamlls = {},
	gopls = {},
	bashls = {},
	htmx = {
		filetypes = {
			"templ",
			"html",
		},
	},
	tailwindcss = {
		filetypes = {
			"templ",
			"svelte",
			"html",
			"javascriptreact",
			"typescriptreact",
			"css",
		},
		init_options = {
			userLanguages = {
				templ = "html",
			},
		},
	},
	svelte = {},
	templ = {},
	rust_analyzer = {},
	jdtls = {},
	-- marksman = {},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
}

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded",
	close_events = { "BufHidden", "InsertLeave" },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

vim.diagnostic.config({
	float = { border = "rounded" },
})

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
	automatic_installation = true,
})
mason_lspconfig.setup_handlers({
	function(server_name)
		if server_name == "jdtls" then
			return
		end
		lspconfig[server_name].setup({
			capabilities = capabilities,
			on_attach = function()
				vim.api.nvim_exec_autocmds("User", { pattern = "LSPKeymaps" })
			end,
			settings = servers[server_name],
			filetypes = (servers[server_name] or {}).filetypes,
			init_options = (servers[server_name] or {}).init_options,
		})
	end,
})

local configs = require("lspconfig.configs")
configs.barium = {
	default_config = {
		cmd = { "barium" },
		filetypes = { "brazil-config" },
		root_dir = function(fname)
			return lspconfig.util.find_git_ancestor(fname)
		end,
		on_attach = function()
			vim.api.nvim_exec_autocmds("User", { pattern = "LSPKeymaps" })
		end,
		settings = {},
	},
}
lspconfig.barium.setup({})
