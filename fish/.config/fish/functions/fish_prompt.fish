function fish_prompt --description 'Write out the prompt'
    set -l last_status $status

    # set_color $fish_color_user
    # echo -n (whoami)
    # set_color normal

    # echo -n '@'

    # set_color $fish_color_host
    # echo -n (prompt_hostname)
    # set_color normal

    # echo -n ':'

    set_color --bold $fish_color_cwd
    echo -n (prompt_pwd)
    set_color normal

    __terlar_git_prompt
    __fish_hg_prompt
    echo

    if test $last_status -eq 0
        set_color --bold $fish_color_user
    else
        set_color --bold $fish_color_error
    end

    echo -n '$ '
    set_color normal
end
