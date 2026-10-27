#!/usr/bin/env bash
# Stop / StopFailure / Notification(permission_prompt) hook: tell the user this
# Claude session needs a look.
# - BEL: tmux flags the window (🔔 in the status bar via window-status-format)
#   and forwards the bell to Ghostty (dock bounce + 🔔 in the title).
# - OSC 777: Ghostty turns it into a macOS notification; it only shows while
#   Ghostty is unfocused and needs `allow-passthrough all` in tmux.
# Hooks have no controlling terminal, so the sequence goes back through
# `terminalSequence` and Claude Code writes it to the pane itself.
input=$(cat)
window=$(tmux display -p -t "$TMUX_PANE" '#I:#W' 2>/dev/null)
body=$(jq -r '(.last_assistant_message // .message // "Seni bekliyor") | gsub("\\s+"; " ") | .[0:140]' <<<"$input")
seq=$(printf '\a\033]777;notify;Claude [%s];%s\a' "$window" "$body")
jq -nc --arg seq "$seq" '{terminalSequence: $seq}'
