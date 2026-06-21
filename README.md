# dotfiles

## WSL Kurduktan Sonra

İlk iş kullanıcıma `NOPASSWD` sudo yetkisi vermek, bunun için:

```bash
visudo
```

yazıp en sona bunu ekliyoruz:

```bash
omerfi  ALL=(ALL) NOPASSWD: ALL
```

Sonraki adımlar

sudo apt update

Install [fish and set as default](https://fishshell.com/docs/current/index.html)

Install [starship](https://starship.rs/guide/)

Install [wslu](https://wslutiliti.es/wslu/install.html)

Install [GitHub CLI](https://github.com/cli/cli#installation) and login with `gh auth login`, choose Github.com and SSH and do not upload ssh key (skip)

```bash
sudo apt install build-essential

sudo apt install tmux neovim ncdu curl
```

Install [cargo](https://doc.rust-lang.org/cargo/getting-started/installation.html)

Install [uv](https://docs.astral.sh/uv/#getting-started) and install python 3.10 and 3.12: `uv python install 3.10 3.12`

Install [eza](https://github.com/eza-community/eza/blob/main/INSTALL.md), [bat](https://github.com/sharkdp/bat/tree/master?tab=readme-ov-file#installation), [fd](https://github.com/sharkdp/fd?tab=readme-ov-file#installation), [xcp](https://github.com/tarka/xcp?tab=readme-ov-file#installation), [ripgrep](https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation)

Install [fisher](https://github.com/jorgebucaran/fisher?tab=readme-ov-file#installation), after updating [fish_plugins](https://github.com/OmerFI/dotfiles/blob/main/.config/fish/fish_plugins) file, run `fisher update`

## Neovim (LazyVim)

`.config/nvim` [LazyVim](https://www.lazyvim.org/) tabanlı. Yeni makinede:

- Neovim, git, bir C derleyici (`build-essential` / clang), `ripgrep` ve `fd` kurulu olsun (yukarıdaki adımlarda var).
- Bir [Nerd Font](https://www.nerdfonts.com/) kur ve terminalin fontunu o yap — yoksa ikonlar kutu görünür. macOS: `brew install --cask font-jetbrains-mono-nerd-font`.
- `.config/nvim` yerine konduktan sonra ilk `nvim` açılışında plugin'ler otomatik kurulur; `lazy-lock.json` sürümleri sabitler.

## Firefox

`firefox/` — Firefox'a özgü düzeltmeler. Detaylar `firefox/README.md`'de:

- **`intl.accept_languages` bozukluğu** → Xbox / Microsoft girişini kıran 500 (Sync kaynaklı).
- **Unity Asset Store** bozuk Service Worker → `firefox/ublock-my-filters.txt` (uBlock "My filters").
