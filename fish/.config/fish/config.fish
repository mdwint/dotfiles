set PATH ~/bin ~/.cargo/bin ~/.local/bin ~/.poetry/bin /usr/local/opt/libpq/bin $PATH
set -xU LC_ALL en_US.UTF-8
set -xU LC_CTYPE en_US.UTF-8

set -xU FZF_DEFAULT_COMMAND 'rg --files --hidden'
# set -xU MANPAGER 'most -wd'

alias l 'ls -lh'
alias tree "exa -T -I='__pycache__|node_modules'"
alias vim nvim
alias gl 'git log'
alias gg 'git log --all --graph --oneline --decorate'
alias gs 'git status'
alias gd 'git diff'
alias gD 'git diff --staged'
alias ga 'git add'
alias gc 'git checkout'
alias gC 'git commit'
alias gp 'git pull'
alias gP 'git push'

direnv hook fish | source
pyenv init - | source
rbenv init - | source

if status --is-interactive
    thefuck --alias | source
    source /usr/local/share/autojump/autojump.fish

    set BASE16_SHELL ~/.config/base16-shell/
    source $BASE16_SHELL/profile_helper.fish
    source ~/.config/base16-fzf/fish/base16-$BASE16_THEME.fish

    set fish_greeting
    set -U fish_color_cwd               brwhite
    set -U fish_color_escape            brcyan
    set -U fish_color_operator          cyan
    set -U fish_pager_color_description yellow
    set -U fish_prompt_pwd_dir_length 0
end
