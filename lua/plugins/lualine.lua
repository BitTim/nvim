return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	opts = { theme = "auto" },
	config = function()
		require('lualine').setup({
			sections = {
				lualine_x = { "encoding", { "fileformat", symbols = { unix = "" } }, "filetype" },
			},
		})
	end
}
