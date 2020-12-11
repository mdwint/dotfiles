set -U fish_features qmark-noglob

set PATH ~/bin ~/go/bin ~/.cargo/bin ~/.local/bin ~/.poetry/bin /usr/local/opt/libpq/bin $PATH
set -xU LC_ALL en_US.UTF-8
set -xU LC_CTYPE en_US.UTF-8

abbr l 'ls -lh'
alias tree "exa -T -I='__pycache__|node_modules'"
alias vim nvim
abbr v vim
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
abbr gp 'git pull'
abbr gP 'git push'

eval (direnv hook fish)
pyenv init - | source
rbenv init - | source

if status --is-interactive
    set -xg FZF_DEFAULT_COMMAND "rg --files --follow --hidden -g '!{.git,_vendor_*}'"
    set -xg FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

    set -xg LYNX_CFG ~/.config/lynx/lynx.cfg
    set -xg LYNX_LSS ~/.config/lynx/lynx.lss

    thefuck --alias | source
    source /usr/local/share/autojump/autojump.fish

    function e -d 'jump and open vim'
        j $argv && vim
    end

    function ? -d 'web search in lynx'
        lynx "https://duckduckgo.com/lite?q=$argv"
    end

    function darkmode
        osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to '$argv
    end

    alias dark 'base16-black && darkmode true'
    alias light 'base16-one-light && darkmode false'

    set BASE16_SHELL ~/.config/base16-shell/
    source $BASE16_SHELL/profile_helper.fish
    source ~/.config/base16-fzf/fish/base16-$BASE16_THEME.fish

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
