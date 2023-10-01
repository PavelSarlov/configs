local status_ok, lsp = pcall(require, 'lspconfig')
if status_ok then
  lsp.sumneko_lua.setup({
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  })
end
