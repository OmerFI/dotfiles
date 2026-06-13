-- Python araçları uv ile yönetilir (sistem python'ı / pip yok).
-- `ruff` -> `uv tool install ruff` ile kuruldu, PATH'ten (~/.local/bin) çözülür.
-- Mason ruff'u pip/python3 ile kurmaya çalışıp hata veriyordu; mason=false ile
-- Mason'ın kurulumunu kapatıp PATH'teki ruff'u kullandırıyoruz.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff = { mason = false },
      },
    },
  },
}
