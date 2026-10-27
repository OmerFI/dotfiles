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

wslu tarayıcıyı `wslview` ile açar ama `xdg-open` adında bir komut kurmaz. rclone gibi bazı araçlar tarayıcıyı açarken doğrudan `xdg-open`'ı çalıştırdığından, `xdg-open`'ı `wslview`'a bağlayan bir symlink oluştur (wslu Mart 2025'te arşivlendi ama `wslview` çalışmaya devam ediyor):

```bash
mkdir -p ~/.local/bin && ln -sf "$(command -v wslview)" ~/.local/bin/xdg-open
```

Install [GitHub CLI](https://github.com/cli/cli#installation) and login with `gh auth login`, choose Github.com and SSH and do not upload ssh key (skip)

```bash
sudo apt install build-essential

sudo apt install tmux neovim ncdu curl
```

Install [cargo](https://doc.rust-lang.org/cargo/getting-started/installation.html)

Install [uv](https://docs.astral.sh/uv/#getting-started) and install python 3.10 and 3.12: `uv python install 3.10 3.12`

Install [eza](https://github.com/eza-community/eza/blob/main/INSTALL.md), [bat](https://github.com/sharkdp/bat/tree/master?tab=readme-ov-file#installation), [fd](https://github.com/sharkdp/fd?tab=readme-ov-file#installation), [xcp](https://github.com/tarka/xcp?tab=readme-ov-file#installation), [ripgrep](https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation)

Install [fisher](https://github.com/jorgebucaran/fisher?tab=readme-ov-file#installation), after updating [fish_plugins](https://github.com/OmerFI/dotfiles/blob/main/.config/fish/fish_plugins) file, run `fisher update`

### Opsiyonel

Kritik değil, ihtiyaç oldukça kurulabilir:

- [rclone](https://rclone.org/install/) — bulut depolama servisleriyle dosya senkronizasyonu için.

## Neovim (LazyVim)

`.config/nvim` [LazyVim](https://www.lazyvim.org/) tabanlı. Yeni makinede:

- Neovim, git, bir C derleyici (`build-essential` / clang), `ripgrep` ve `fd` kurulu olsun (yukarıdaki adımlarda var).
- Bir [Nerd Font](https://www.nerdfonts.com/) kur ve terminalin fontunu o yap — yoksa ikonlar kutu görünür. macOS: `brew install --cask font-jetbrains-mono-nerd-font`.
- `.config/nvim` yerine konduktan sonra ilk `nvim` açılışında plugin'ler otomatik kurulur; `lazy-lock.json` sürümleri sabitler.

## Claude Code bildirimleri

Claude bir turu bitirdiğinde, API hatasıyla durduğunda ya da izin beklediğinde `.claude/hooks/claude-notify.sh` tmux penceresine bell gönderir ve terminale bir masaüstü bildirimi (OSC 777) yollar. `.tmux.conf` bu bell'i yakalayıp pencere adının önüne Nerd Font zilini koyar, zil de o pencereye geçince kendiliğinden kalkar.

Script `jq` kullanır; macOS'ta hazır gelir, WSL'de ayrıca kurulması gerekir:

```bash
sudo apt install jq
mkdir -p ~/.claude/hooks && xcp ~/dotfiles/.claude/hooks/claude-notify.sh ~/.claude/hooks/
```

Ardından `~/.claude/settings.json` dosyasındaki `hooks` nesnesine şunları ekle:

```json
"Stop": [{ "hooks": [{ "type": "command", "command": "$HOME/.claude/hooks/claude-notify.sh" }] }],
"StopFailure": [{ "hooks": [{ "type": "command", "command": "$HOME/.claude/hooks/claude-notify.sh" }] }],
"Notification": [{ "matcher": "permission_prompt", "hooks": [{ "type": "command", "command": "$HOME/.claude/hooks/claude-notify.sh" }] }]
```

Terminal tarafında ise şunlar geçerli:

- **Ghostty (macOS):** Ek ayar gerekmez. Masaüstü bildirimi yalnızca Ghostty arka plandayken çıkar ve System Settings → Notifications altında Ghostty'ye izin verilmiş olmalıdır.
- **Windows Terminal (WSL):** Varsayılan bell her seferinde ses çalar; WSL profiline `"bellStyle": "taskbar"` eklersen ses yerine görev çubuğundaki ikon yanıp söner. Masaüstü bildirimi yalnızca Preview 1.26 ve sonrasında, profile `"compatibility.allowOSC777": true` eklendiğinde gelir. Stable sürümde bildirim gelmese de status bar'daki zil çalışır.
- Arka plandaki pencereden bildirimin geçebilmesi için tmux 3.4 veya üstü gerekir. Daha eski sürümde yalnızca masaüstü bildirimi gelmez, zil yine görünür.

## Firefox

`firefox/` — Firefox'a özgü düzeltmeler. Detaylar `firefox/README.md`'de:

- **`intl.accept_languages` bozukluğu** → Xbox / Microsoft girişini kıran 500 (Sync kaynaklı).
- **Unity Asset Store** bozuk Service Worker → `firefox/ublock-my-filters.txt` (uBlock "My filters").

## macOS

`macos/` — macOS'a özgü, opsiyonel düzeltmeler. Detaylar `macos/README.md`'de:

- **Uzantısız metin dosyaları çift tıklayınca TextEdit'te açılıyor** → dosyaya `'TEXT'` tip kodu damgalayıp Zed'e yönlendirme (`set-zed-as-text-editor.swift` + `zed-mark.py`).
