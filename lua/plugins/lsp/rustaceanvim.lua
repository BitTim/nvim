return {
	'mrcjkb/rustaceanvim',
	-- To avoid being surprised by breaking changes,
	-- I recommend you set a version range
	version = '^9',
	-- This plugin implements proper lazy-loading (see :h lua-plugin-lazy).
	-- No need for lazy.nvim to lazy-load it.
	lazy = false,
	config = function()
		local config_path = vim.fn.stdpath("config")
		local settings_file = config_path .. "/after/lsp/rust_analyzer.lua"

		if vim.fn.filereadable(settings_file) == 1 then
			local rust_settings = dofile(settings_file)

			vim.g.rustaceanvim = {
				server = {
					cmd = rust_settings.cmd,
					default_settings = rust_settings.settings,
				},
			}
		else
			vim.notify("Did not find rust settings in " .. settings_file, vim.log.levels.WARN)
		end
	end,
}
