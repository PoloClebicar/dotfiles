return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    keywords = {
      FIX = {
        icon = " ", -- icon used for the sign, and in search results
        color = "#EE4266", -- can be a hex color, or a named color (see below)
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
        -- signs = false, -- configure signs for some keywords individually
      },
      TODO = { icon = " ", color = "#3ABEFF" },
      HACK = { icon = " ", color = "#A01A7D" },
      WARN = { icon = " ", color = "#F1D302", alt = { "WARNING", "XXX" } },
      PERF = { icon = " ", color = "#00BD9D", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "#2A9134", alt = { "INFO" } },
      TEST = { icon = "⏲ ", color = "#C4CBCA", alt = { "TESTING", "PASSED", "FAILED" } },
    },
  },
}

--HACK:
--WARNING:
--XXX:
--NOTE:
--INFO:
--TODO:
--teadfasdfasdfasdf
--TEST:
--PASSED:
--PERF:
--FIX:
--BUG:
--FIXME:
