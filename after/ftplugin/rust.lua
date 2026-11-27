local bufnr = vim.api.nvim_get_current_buf()

local function rust_fallback(rust_subcmd, native_fn)
	return function()
		if vim.fn.exists(":RustLsp") > 0 then
			vim.cmd("RustLsp " .. rust_subcmd)
		else
			native_fn()
		end
	end
end

-- Remap builtin LSP keybinds to use RustLsp first
local mappings = {
	{ "n", "gra", rust_fallback("codeAction", vim.lsp.buf.code_action), "Code Actions" },
	{ "n", "K",   rust_fallback("hover actions", vim.lsp.buf.hover),    "Hover Actions" },
	{ "n", "gD",  rust_fallback("openDocs", vim.lsp.buf.declaration),   "Go to Declaration / Docs" },

	{ "n", "grn", vim.lsp.buf.rename,                                   "Rename Symbol" },
	{ "n", "grr", vim.lsp.buf.references,                               "Go to References" },
	{ "n", "gd",  vim.lsp.buf.definition,                               "Go to Definition" },
	{ "n", "gi",  vim.lsp.buf.implementation,                           "Go to Implementation" },
	{ "n", "go",  vim.lsp.buf.document_symbol,                          "Document Symbols" },
}

-- Map all keymaps for current buffer
for _, map in ipairs(mappings) do
	vim.keymap.set(map[1], map[2], map[3], {
		silent = true,
		buffer = bufnr,
		desc = "Rust: " .. map[4],
	})
end
