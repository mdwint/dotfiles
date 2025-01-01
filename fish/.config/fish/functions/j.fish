function j -d 'jump to or fuzzy-find a directory'
    if test -n "$argv"
        __zoxide_z $argv

        # In git repos with worktrees, enter the first worktree.
        if string match -q '*.git' (pwd)
            for branch in develop master
                if test -d $branch; cd $branch; break; end
            end
        end
    else
        # Fuzzy-find a directory in home.
        set -l opts -d 5 -E Applications -E Documents -E Library -E Music
        cd (cd && fd -t d $opts | fzf --preview='tree {}')
    end
end
