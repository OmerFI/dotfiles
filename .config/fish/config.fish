if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Signal truecolor only when the outer terminal is Windows Terminal (which
# supports it). tmux strips COLORTERM from its update-environment list, so it
# never reaches the shell otherwise. The real RGB capability is set in tmux.conf.
if set -q WT_SESSION
    set -gx COLORTERM truecolor
end

# run fish_key_reader to find keys
bind \b backward-kill-word
bind \e\[3\;5~ kill-word

fish_add_path $HOME/neovim/bin
fish_add_path $HOME/.local/bin

ssh-add ~/.ssh/github &> /dev/null


# pyenv
# set -Ux PYENV_ROOT $HOME/.pyenv
# fish_add_path $PYENV_ROOT/bin
# pyenv init - | source

# uv
# publish
# set -x UV_PUBLISH_URL "REDACTED"
# set -x UV_PUBLISH_USERNAME "REDACTED"
# set -x UV_PUBLISH_PASSWORD "REDACTED"
# index
# set -x UV_DEFAULT_INDEX "REDACTED"

# Node: .nvmrc ya da .node-version dosyası olan bir klasöre (veya onun alt klasörlerine)
# girildiğinde o sürüme, böyle bir dosya olmayan yerlerde varsayılan sürüme geçilir.
set --global nvm_default_version 26

function _node_version_auto_use --on-variable PWD
    set --local spec $nvm_default_version
    set --local dir $PWD
    while true
        if test -f $dir/.nvmrc
            read spec <$dir/.nvmrc
            break
        else if test -f $dir/.node-version
            read spec <$dir/.node-version
            break
        end
        test $dir = /; and break
        set dir (path dirname $dir)
    end
    test "$spec" = "$_node_version_auto_use_spec"; and return
    nvm use --silent $spec; and set --global _node_version_auto_use_spec $spec
end
_node_version_auto_use
