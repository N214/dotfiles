return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
  build = ":MasonUpdate",
  opts = {
    ensure_installed = {
      "stylua",
      "shfmt",
      "black",
      "eslint_d",
      "json-lsp",
      "html-lsp",
      "lua-language-server",
      "node-debug2-adapter",
      "prettierd",
      "typescript-language-server",
      "tailwindcss-language-server",
      "ruff",
      "nextls",
      "svelte-language-server",
      "gopls",
      "templ",
      "go-debug-adapter",
      "gospel",
      "goimports-reviser",
      "gofumpt",
      "impl",
    },
  },
  ---@param opts MasonSettings | {ensure_installed: string[]}
  config = function(_, opts)
    require("mason").setup(opts)
    local mr = require("mason-registry")
    mr:on("package:install:success", function()
      vim.defer_fn(function()
        -- trigger FileType event to possibly load this newly installed LSP server
        require("lazy.core.handler.event").trigger({
          event = "FileType",
          buf = vim.api.nvim_get_current_buf(),
        })
      end, 100)
    end)
    local function ensure_installed()
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end
    if mr.refresh then
      mr.refresh(ensure_installed)
    else
      ensure_installed()
    end
  end,
}
