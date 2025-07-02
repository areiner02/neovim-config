return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    "hrsh7th/cmp-nvim-lsp"
  },
  keys = {
    { "gd", vim.lsp.buf.definition, { silent = true } },
    { "gr", vim.lsp.buf.references },
    { "K", vim.lsp.buf.hover },
    { "<leader>r", function(replace_with) vim.lsp.buf.rename(replace_with) end }
  },
  config = function()
    local lspconfig = require("lspconfig")
    local default_capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    lspconfig.lua_ls.setup {
      capabilities = default_capabilities
    }

    lspconfig.clangd.setup {
      capabilities = default_capabilities,
      cmd = { "clangd", "--background-index", "--log=verbose" },
    }

    lspconfig.ts_ls.setup {
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities),
    }

    lspconfig.omnisharp.setup {
      capabilities = default_capabilities,
      enable_roslyn_analyzers = true,
      organize_imports_on_format = true,
      enable_import_completion = true,
      cmd = { vim.fn.stdpath("data") .. "/mason/packages/omnisharp/OmniSharp", "--languageserver" , "--hostPID", tostring(vim.fn.getpid()) },
      root_dir = lspconfig.util.root_pattern("*.sln", "*.csproj"),
    }
  end
}
