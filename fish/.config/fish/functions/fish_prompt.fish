function fish_prompt --description 'Write out the prompt'
    set -l last_status $status

    set -l cwd (prompt_pwd)
    set_color $fish_color_cwd
    echo -n $cwd

    set -l branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if test -n "$branch"
        set_color $fish_color_escape
        echo -n " ($branch)"
    end

    if test (string length "$cwd ($branch)") -ge 20
        echo
    end

    if test $last_status -eq 0
        set_color --bold normal
    else
        set_color --bold $fish_color_error
    end

    echo -n '$ '
    set_color normal
end
