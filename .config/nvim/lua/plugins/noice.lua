-- pyright (ve genel LSP) her tuşta yeniden analiz edip progress mesajı yolluyor;
-- noice bunları sağ-altta "✓ <lsp>" diye gösterip yığıyordu. Kapatıyoruz.
return {
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        progress = { enabled = false },
      },
    },
  },
}
