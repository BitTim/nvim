return {
	'nvim-treesitter/nvim-treesitter',
	lazy = false,
	build = ':TSUpdate',
	config = function()
		local ts = require("nvim-treesitter")

		ts.setup()
		ts.install { 'rust', 'lua', 'nix', 'markdown' }
	end
}
