set PATH ~/bin ~/.cargo/bin ~/.local/bin ~/.poetry/bin /usr/local/opt/libpq/bin $PATH
set -xU LC_ALL en_US.UTF-8
set -xU LC_CTYPE en_US.UTF-8

set -xg FZF_DEFAULT_COMMAND "rg --files --follow --hidden -g '!{.git,_vendor_*}'"
set -xg FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

alias l 'ls -lh'
alias tree "exa -T -I='__pycache__|node_modules'"
alias vim nvim
alias t watson
alias gl 'git log'
alias gg 'git log --all --graph --oneline'
alias gh 'git show HEAD'
alias gs 'git status'
alias gd 'git diff'
alias gD 'git diff --staged'
alias ga 'git add'
alias gc 'git checkout'
alias gC 'git commit'
alias gM 'git merge'
alias gp 'git pull'
alias gP 'git push'

eval (direnv hook fish)
pyenv init - | source
rbenv init - | source

if status --is-interactive
    thefuck --alias | source
    source /usr/local/share/autojump/autojump.fish

    function e -d 'jump and open vim'
        j $argv && vim
    end

    alias dark base16-black
    alias light base16-grayscale-light

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
