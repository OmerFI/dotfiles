abbr -a claer "clear"
abbr -a cls "clear"
abbr -a svba "source .venv/bin/activate.fish"
abbr -a pm "python manage.py"
abbr -a pmr "python manage.py runserver"
abbr -a pms "python manage.py shell"
abbr -a pmma "python manage.py makemigrations"
abbr -a pmmi "python manage.py migrate"
abbr -a xclip "xclip -selection clipboard"

abbr -a vi "nvim"

abbr -a l "ls -lah"
abbr -a e "eza -lah"

abbr -a ipy "ipython"

# Sublime Text, ref: https://www.sublimetext.com/docs/command_line.html
if test (uname) = Darwin
    abbr -a subl "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"
else
    # WSL: subl.exe should be added to Windows PATH manually
    abbr -a subl "subl.exe"
end
