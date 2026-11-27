return {
	cmd = { "rust-analyzer" },
	settings = {
		["rust-analyzer"] = {
			checkOnSave = true,
			check = {
				command = "clippy",
			},
		},
	},
}
