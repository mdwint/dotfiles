function fish_prompt --description 'Write out the prompt'
    set_color $fish_color_cwd
    echo -n (prompt_pwd)

    set -l branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if test -n "$branch"
        set_color $fish_color_escape
        echo -n " ($branch)"
    end

    echo
    set_color --bold normal
    echo -n '$ '
    set_color normal
end
