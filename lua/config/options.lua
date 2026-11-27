-- Disable wrapping
vim.opt.wrap = false

-- Enable line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable cursor line
vim.opt.cursorline = true

-- Set tab size
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- Enable 24-bit RGB colors
vim.opt.termguicolors = true

-- Autoread file into buffer when changed on disk
vim.opt.autoread = true

-- Disable file explorer banner
-- vim.g.netrw_banner = 0

vim.opt.smartindent = true
vim.opt.inccommand = "split"

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.laststatus = 3

-- Disable swap and enable persistent undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

-- Use system clipboard
vim.opt.clipboard:append("unnamedplus")

-- Set scroll offset
vim.opt.scrolloff = 8

-- Folding
_G.custom_foldtext = function()
	local start_line = vim.fn.getline(vim.v.foldstart)
	local end_line = vim.trim(vim.fn.getline(vim.v.foldend))
	local line_count = vim.v.foldend - vim.v.foldstart + 1
	return "    " .. start_line .. " ... " .. end_line .. " (" .. line_count .. " lines)"
end

vim.opt.foldlevel = 4
vim.opt.foldtext = "v:lua.custom_foldtext()"
vim.opt.fillchars = "fold: " -- Removes the ugly trailing dashes (---)

-- Extra columns
vim.opt.signcolumn = "yes"
vim.opt.foldcolumn = "auto:9"

-- Highlight when yanking macro
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.hl.on_yank()
	end,
})

-- File specific highlighting and folding
vim.api.nvim_create_autocmd('FileType', {
	pattern = '*',
	callback = function(args)
		local lang = vim.treesitter.language.get_lang(args.match)

		if lang and vim.treesitter.language.add(lang) then
			-- Highlighting
			vim.treesitter.start(args.buf)

			-- Folding
			vim.wo[0][0].foldmethod = 'expr'
			vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
		else
			-- Fallback folding
			vim.wo[0][0].foldmethod = 'indent'
		end
	end,
})
