if status is-interactive
    # Commands to run in interactive sessions can go here
end

# run fish_key_reader to find keys
bind \b backward-kill-word
bind \e\[3\;5~ kill-word

fish_add_path $HOME/neovim/bin
fish_add_path $HOME/.local/bin


# pyenv
set -Ux PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin
pyenv init - | source

