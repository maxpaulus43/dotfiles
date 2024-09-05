-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require("mason").setup()
require("mason-lspconfig").setup()

local servers = {
	cssls = {},
	html = {},
	tsserver = {},
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
	-- marksman = {},
	-- lua_ls = {
	--   Lua = {
	--     workspace = { checkThirdParty = false },
	--     telemetry = { enable = false },
	--   },
	-- },
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
})
mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
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

function bemol()
	local bemol_dir = vim.fs.find({ ".bemol" }, { upward = true, type = "directory" })[1]
	local ws_folders_lsp = {}
	if bemol_dir then
		local file = io.open(bemol_dir .. "/ws_root_folders", "r")
		if file then
			for line in file:lines() do
				table.insert(ws_folders_lsp, line)
			end
			file:close()
		end
	end

	for _, line in ipairs(ws_folders_lsp) do
		vim.lsp.buf.add_workspace_folder(line)
	end
end
-- local lspconfig = require("lspconfig")
-- local configs = require("lspconfig.configs")
-- if not configs.codewhisperer then
-- 	configs.codewhisperer = {
-- 		default_config = {
-- 			-- Add the codewhisperer to our PATH or BIN folder
-- 			cmd = { "cwls" },
-- 			root_dir = lspconfig.util.root_pattern(
-- 				"packageInfo",
-- 				"package.json",
-- 				"tsconfig.json",
-- 				"jsconfig.json",
-- 				".git"
-- 			),
-- 			filetypes = {
-- 				"java",
-- 				"python",
-- 				"typescript",
-- 				"tsx",
-- 				"jsx",
-- 				"javascript",
-- 				"csharp",
-- 				"ruby",
-- 				"kotlin",
-- 				"shell",
-- 				"sql",
-- 				"c",
-- 				"cpp",
-- 				"go",
-- 				"rust",
-- 				"lua",
-- 			},
-- 		},
-- 	}
-- end
--
-- lspconfig.codewhisperer.setup({ capabilities = capabilities })
