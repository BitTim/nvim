return {
	"rcarriga/nvim-notify",
	lazy = false,
	opts = {
		timeout = 3000,
		stages = "fade_in_slide_out",
		background_colour = "#000000",
	},
	config = function(_, opts)
		local notify = require("notify")
		notify.setup(opts)
		vim.notify = notify -- route all vim.notify calls through it
	end,
}
