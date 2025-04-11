return
{
	"nvim-treesitter/nvim-treesitter",
	config = function () 
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			auto_install = true,
			ensure_installed = {"lua"},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },  
		})
	end
}

