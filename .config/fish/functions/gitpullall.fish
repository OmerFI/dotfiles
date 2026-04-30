function gitpullall --description "Run git pull in every git repository under home"
    set -l search_root $HOME
    set -l exclude_dirs ".nvm" ".cache"

    set -l find_args -name .git -type d -maxdepth 6
    for d in $exclude_dirs
        set find_args $find_args -not -path "*/$d/*"
    end

    set -l repos (find $search_root $find_args 2>/dev/null | sed 's|/.git$||' | sort)

    if test (count $repos) -eq 0
        echo "No git repositories found."
        return
    end

    for repo in $repos
        set -l name (string replace $HOME "~" $repo)
        echo (set_color --bold cyan)"=== $name ==="(set_color normal)
        set -l output (git -C $repo pull 2>&1)
        set -l status_code $status
        if test $status_code -ne 0
            echo (set_color red)$output(set_color normal)
        else if string match -q "Already up to date." $output
            echo (set_color green)$output(set_color normal)
        else
            echo $output
        end
        echo ""
    end
end
