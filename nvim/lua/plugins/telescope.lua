return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	-- or                              , branch = '0.1.x',
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")

		telescope.setup({
			defaults = {
				-- Default configuration for telescope
				prompt_prefix = " ",
				selection_caret = " ",
				path_display = { "truncate" },
			},
			pickers = {
				find_files = {
					-- Makes find_files show hidden files
					hidden = true,
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
			},
		})
	end,
}
