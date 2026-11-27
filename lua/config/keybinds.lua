-- Map leader keys
vim.g.mapleader = " "

-- ================================
--  LSP
-- ================================

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local function map(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
		end

		map("n", "gd", vim.lsp.buf.definition, "Go to definition")
		map("n", "grr", "<cmd>Telescope lsp_references<CR>", "References")
		map("n", "gri", "<cmd>Telescope lsp_implementations<CR>", "Implementations")
		map("n", "grt", "<cmd>Telescope lsp_type_definitions<CR>", "Type definition")
		map("n", "<leader>d", vim.diagnostic.open_float, "Line diagnostics")
		map("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Buffer diagnostics")
	end,
})
