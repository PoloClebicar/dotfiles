require("config.lazy")

-- Basic editor settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 100
vim.opt.clipboard = "unnamedplus"
vim.g.have_nerd_font = true
vim.opt.mouse = "a"

--Required Telescope set up
local builtin = require("telescope.builtin")

--Remapping keys
--Find files, default to searching GIT, ig no git project, defaults
--to current work directory
vim.keymap.set("n", "<leader>ff", function()
  local builtin = require("telescope.builtin")
  local git_dir = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null")
  git_dir = git_dir:gsub("%s+$", "")
  if vim.v.shell_error == 0 and git_dir ~= "" then
    builtin.find_files({ cwd = git_dir, hidden = true })    -- show dotfiles inside git project
  else
    builtin.find_files({ hidden = true })                   -- also show dotfiles outside git
  end
end, { desc = "Find files in project (including hidden)" }) --More hotkeys for telescope

vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
--
-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "[G]ets [F]ormatting before writing a file",
  group = vim.api.nvim_create_augroup("polo-get-formatter", { clear = true }),
  callback = function()
    vim.lsp.buf.format()
  end,
})
--
-- vim.keymap.set("n", "<leader>mdr", ":RenderMarkdown<CR>")
-- vim.diagnostic.config({
--   virtual_text = {
--     wrap = true, -- Enable text wrapping
--   },
-- })
vim.diagnostic.config({
  virtual_text = false,
  float = { border = "rounded" }, -- Make it look nicer
})

vim.keymap.set({ "n", "v" }, "<leader>k", vim.diagnostic.open_float, { noremap = true, silent = true })

--Oil Setup
require("oil").setup({
  view_options = {
    show_hidden = true,
  },
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function()
  harpoon:list():add()
end)
vim.keymap.set("n", "<C-e>", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set("n", "<C-h>", function()
  harpoon:list():select(1)
end)
vim.keymap.set("n", "<C-j>", function()
  harpoon:list():select(2)
end)
vim.keymap.set("n", "<C-k>", function()
  harpoon:list():select(3)
end)
vim.keymap.set("n", "<C-l>", function()
  harpoon:list():select(4)
end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function()
  harpoon:list():prev()
end)
vim.keymap.set("n", "<C-S-N>", function()
  harpoon:list():next()
end)

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers")
      .new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      })
      :find()
end

vim.keymap.set("n", "<C-e>", function()
  toggle_telescope(harpoon:list())
end, { desc = "Open harpoon window" })
