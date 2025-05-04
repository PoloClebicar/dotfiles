return {
	"nvimdev/indentmini.nvim",
	config = function()
		require("indentmini").setup() -- use default config
		-- Colors are applied automatically based on user-defined highlight groups.
		-- There is no default value.
		vim.cmd.highlight("IndentLine guifg=#3C4367")
		-- Current indent line highlight
		vim.cmd.highlight("IndentLineCurrent guifg=#e6edf3")
	end,
}
