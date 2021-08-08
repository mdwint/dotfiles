if status --is-login; and not set -q __fish_login_config_sourced
    set -U fish_features stderr-nocaret qmark-noglob

    set -xU LC_ALL en_US.UTF-8
    set -xU LC_CTYPE en_US.UTF-8
    set -xU PYENV_ROOT $HOME/.pyenv

    fish_add_path ~/bin ~/go/bin ~/.cargo/bin ~/.local/bin ~/.poetry/bin $PYENV_ROOT/bin /usr/local/opt/libpq/bin

    set -x __fish_login_config_sourced 1
end

if status --is-interactive
    if type -q direnv; eval (direnv hook fish); end
    if type -q pyenv; pyenv init --path --no-rehash | source; end
    if type -q zoxide; zoxide init fish --cmd j | source; end

    abbr l 'ls -lh'
    abbr chmox 'chmod +x'
    alias vim nvim
    abbr v vim
    abbr d date
    abbr t watson
    abbr tl 'watson log -c'
    abbr pr pull-request
    abbr gl 'git log'
    abbr gg 'git log --all --graph --oneline'
    abbr gh 'git show HEAD'
    abbr gs 'git status'
    abbr gd 'git diff'
    abbr gD 'git diff --staged'
    abbr ga 'git add'
    abbr gc 'git checkout'
    abbr gC 'git commit'
    abbr gCa 'git commit --amend'
    abbr gCan 'git commit --amend --no-edit'
    abbr gM 'git merge'
    abbr gf 'git fetch --all'
    abbr gp 'git pull'
    abbr gP 'git push'
    abbr gPu 'git push -u origin HEAD'
    abbr gPf 'git push --force-with-lease'

    set -xg FZF_DEFAULT_COMMAND "rg --files --follow --hidden -g '!{.git,_vendor_*}'"
    set -xg FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
    set -xg FZF_DEFAULT_OPTS '--color 16'

    function ccd -d 'mkdir and cd'; mkdir -p $argv && cd $argv; end

    function e -d 'jump and open vim'; j $argv && vim; end

    function jj -d 'fzf and cd'
        set opts -d 5 -E Applications -E Documents -E Library -E Music
        cd (cd && fd -t d $opts | fzf --preview='tree {}')
    end

    function darkmode -d 'set macOS dark mode (true/false)'
        osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to '$argv
    end

    alias dark 'base16-dark && darkmode true'
    alias light 'base16-light && darkmode false'

    set BASE16_SHELL ~/.config/base16-shell/profile_helper.fish
    if test -e $BASE16_SHELL; source $BASE16_SHELL; end

    set -U fish_color_autosuggestion    cyan
    set -U fish_color_command           normal
    set -U fish_color_comment           normal
    set -U fish_color_cwd               brwhite
    set -U fish_color_end               cyan
    set -U fish_color_error             normal
    set -U fish_color_escape            brcyan
    set -U fish_color_operator          cyan
    set -U fish_color_param             normal
    set -U fish_color_quote             normal
    set -U fish_color_redirection       cyan
    set -U fish_pager_color_description yellow
    set -U fish_prompt_pwd_dir_length   0
    set fish_greeting
end
