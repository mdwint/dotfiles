set -U fish_features stderr-nocaret qmark-noglob

fish_add_path ~/bin ~/go/bin ~/.cargo/bin ~/.local/bin ~/.poetry/bin /usr/local/opt/libpq/bin
set -xU LC_ALL en_US.UTF-8
set -xU LC_CTYPE en_US.UTF-8

abbr l 'ls -lh'
alias tree "exa -T -I='__pycache__|node_modules'"
abbr chmox 'chmod +x'
alias vim nvim
abbr v vim
abbr d date
abbr t watson
abbr tl 'watson log -c'
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

if type -q direnv; eval (direnv hook fish); end

if type -q pyenv
    set -Ux PYENV_ROOT $HOME/.pyenv
    set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
    pyenv init --path --no-rehash | source
end

if status --is-interactive
    set -xg FZF_DEFAULT_COMMAND "rg --files --follow --hidden -g '!{.git,_vendor_*}'"
    set -xg FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

    set -xg LYNX_CFG ~/.config/lynx/lynx.cfg
    set -xg LYNX_LSS ~/.config/lynx/lynx.lss

    if type -q thefuck; thefuck --alias | source; end

    set AUTOJUMP /usr/local/share/autojump/autojump.fish
    if test -e $AUTOJUMP; source $AUTOJUMP; end

    function e -d 'jump and open vim'; j $argv && vim; end

    function z -d 'fuzzy find and change directory'
        set dest (fd --type directory $argv | fzf) && cd $dest
    end

    alias zz 'z --max-depth 3 . ~'

    function ? -d 'web search in lynx'
        lynx "https://duckduckgo.com/lite?q=$argv"
    end

    function darkmode
        osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to '$argv
    end

    alias dark 'base16-black && darkmode true'
    alias light 'base16-one-light && darkmode false'

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
