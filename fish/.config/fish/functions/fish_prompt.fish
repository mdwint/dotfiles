function fish_prompt --description 'Write out the prompt'
    set_color $fish_color_cwd
    echo -n (prompt_pwd)

    set -l branch (
        git symbolic-ref -q --short HEAD 2> /dev/null ||
        git rev-parse --short HEAD 2> /dev/null
    )
    if test -n "$branch"
        set -l tag (git describe --tags --exact-match 2> /dev/null)
        if test -n "$tag"; set branch "$branch, $tag"; end
        set_color $fish_color_escape
        echo -n " ($branch)"
    end

    echo
    set_color --bold normal
    echo -n '$ '
    set_color normal
end
