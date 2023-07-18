if status --is-login; and not set -q __fish_login_config_sourced
    set -U fish_features qmark-noglob

    set -xU EDITOR nvim
    set -xU LC_ALL en_US.UTF-8
    set -xU LC_CTYPE en_US.UTF-8
    set -xU PYENV_ROOT $HOME/.pyenv

    fish_add_path ~/bin ~/go/bin ~/.cargo/bin ~/.local/bin /opt/homebrew/bin /usr/local/opt/libpq/bin

    set -x __fish_login_config_sourced 1
end

if status --is-interactive
    if type -q direnv; eval (direnv hook fish); end
    if type -q fnm; eval (fnm env); end
    if type -q pyenv; pyenv init --path --no-rehash | source; end
    if type -q zoxide; zoxide init fish | source; end

    abbr l 'ls -lh'
    abbr chmox 'chmod +x'
    alias vim nvim
    abbr pr pull-request
    abbr o origin
    abbr gl 'git log'
    abbr gg 'git log --all --graph --oneline'
    abbr gh 'git show HEAD'
    abbr gs 'git status'
    abbr gd 'git diff'
    abbr gD 'git diff --staged'
    abbr ga 'git add'
    abbr gap 'git add --patch'
    abbr gc 'git checkout'
    abbr gC 'git commit'
    abbr gCa 'git commit --amend'
    abbr gCan 'git commit --amend --no-edit'
    abbr gM 'git merge'
    abbr gf 'git fetch --all --prune'
    abbr gp 'git pull'
    abbr gP 'git push'
    abbr gPu 'git push -u origin HEAD'
    abbr gPf 'git push --force-with-lease'

    set -xg FZF_DEFAULT_COMMAND "rg --files --follow --hidden -g '!{.git,_vendor_*}'"
    set -xg FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
    set -xg FZF_DEFAULT_OPTS '--color 16'

    function ccd -d 'mkdir and cd'; mkdir -p $argv && cd $argv; end

    function j -d 'jump or fzf directory'
        if test -n "$argv"
            z $argv
        else
            set opts -d 5 -E Applications -E Documents -E Library -E Music
            cd (cd && fd -t d $opts | fzf --preview='tree {}')
        end
    end

    colors

    set -U fish_color_autosuggestion    cyan
    set -U fish_color_command           normal
    set -U fish_color_comment           brblack
    set -U fish_color_cwd               brwhite
    set -U fish_color_end               normal
    set -U fish_color_error             normal
    set -U fish_color_escape            cyan
    set -U fish_color_operator          normal
    set -U fish_color_param             normal
    set -U fish_color_quote             normal
    set -U fish_color_redirection       normal
    set -U fish_color_valid_path        normal
    set -U fish_pager_color_completion  cyan
    set -U fish_pager_color_description cyan
    set -U fish_pager_color_prefix      normal
    set -U fish_pager_color_progress    normal
    set -U fish_prompt_pwd_dir_length   0
    set fish_greeting
end
