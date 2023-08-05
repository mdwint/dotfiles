function j -d 'jump or fzf directory'
    if test -n "$argv"
        z $argv
    else
        set opts -d 5 -E Applications -E Documents -E Library -E Music
        cd (cd && fd -t d $opts | fzf --preview='tree {}')
    end
end
