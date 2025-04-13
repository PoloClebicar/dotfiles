return {
  -- Mason: Package manager for Neovim that makes it easy to install LSP servers, DAP servers, linters, and formatters
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason-lspconfig: Bridge between Mason and lspconfig, making it easier to use LSP servers installed via Mason
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        -- Automatically install these LSP servers when setting up
        ensure_installed = {
          "clangd", -- C/C++ language server
          "lua_ls", -- Lua language server
          "ts_ls", -- TypeScript/JavaScript language server
        },
      })
    end,
  },

  -- nvim-lspconfig: Configuration for Neovim's built-in LSP client
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Get default capabilities from nvim-cmp to enable autocompletion
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      -- Common on_attach function that will be used for all language servers
      -- This runs whenever an LSP connects to a buffer
      local on_attach = function(client, bufnr)
        -- Setup auto-formatting on save for this buffer
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            -- Format the current buffer synchronously when saving
            vim.lsp.buf.format({ async = false })
          end,
        })

        -- Set up buffer-specific keymaps (only apply to buffers with LSP active)
        -- Show documentation on hover
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
        -- Go to definition of symbol under cursor
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
        -- Show code actions menu (like auto-imports, refactoring options)
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
      end

      -- Setup for Lua language server
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }, -- Recognize 'vim' global for Neovim config files
            },
          },
        },
      })

      -- Setup for TypeScript/JavaScript language server
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        -- TypeScript-specific settings
        settings = {
          typescript = {
            inlayHints = {
              -- Show parameter names as inlay hints
              includeInlayParameterNameHints = "all",
              -- Don't show parameter hints when the parameter name matches the argument name
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              -- Show function parameter type hints
              includeInlayFunctionParameterTypeHints = true,
              -- Show variable type hints
              includeInlayVariableTypeHints = true,
              -- Show property declaration type hints
              includeInlayPropertyDeclarationTypeHints = true,
              -- Show function return type hints
              includeInlayFunctionLikeReturnTypeHints = true,
            },
          },
          -- Same inlay hint settings for JavaScript
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
            },
          },
        },
      })

      -- Setup for Dart language server
      lspconfig.dartls.setup({
        -- Specific command to start the Dart language server
        cmd = { "dart", "language-server", "--protocol=lsp" },
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          dart = {
            -- Auto-complete function calls by adding parentheses and argument placeholders
            completeFunctionCalls = true,
            -- Show TODO comments in the Problems panel
            showTodos = true,
            -- Update imports when renaming files
            updateImportsOnRename = true,
            -- Set preferred line length for formatting
            lineLength = 80,
          },
        },
      })

      -- Setup for C/C++ language server
      lspconfig.clangd.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = {
          "clangd",
          "--background-index",    -- Index project in the background
          "--suggest-missing-includes", -- Suggest missing headers
          "--clang-tidy",          -- Enable clang-tidy diagnostics
          "--header-insertion=iwyu", -- Insert headers when necessary
        },
      })

      -- Global keymaps (available everywhere, not buffer-specific)
      -- Rename symbol under cursor
      vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, {})
      -- Format current buffer/selection
      vim.keymap.set("n", "<leader>lf", function()
        vim.lsp.buf.format({ async = true })
      end, {})
    end,
  },
}
