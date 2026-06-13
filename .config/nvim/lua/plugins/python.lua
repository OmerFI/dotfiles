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
        -- uv projeleri hep kökte .venv tutar; pyright'a onu otomatik tanıt
        -- (yoksa sistem python'ına bakar ve django/ninja gibi importlar çözülmez).
        pyright = {
          before_init = function(params, config)
            local root = config.root_dir or params.rootPath or vim.fn.getcwd()
            local py = root and (root .. "/.venv/bin/python")
            if py and vim.uv.fs_stat(py) then
              config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
                python = { pythonPath = py },
              })
            end
          end,
        },
      },
    },
  },
}
