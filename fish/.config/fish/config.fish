set fish_greeting
set fish_color_user normal
set fish_color_cwd brblue
set -U fish_prompt_pwd_dir_length 0

set PATH ~/bin ~/.cargo/bin ~/.poetry/bin $PATH

set -xU FZF_DEFAULT_COMMAND 'rg --files --hidden'
set -xU MANPAGER 'most -wd'

alias l 'exa -l'
alias tree "exa -T -I='__pycache__|node_modules'"
alias vim nvim
alias gl 'git log'
alias gg 'git log --all --graph --oneline --decorate'
alias gs 'git status'
alias gd 'git diff'
alias gD 'git diff --staged'
alias ga 'git add'

direnv hook fish | source
thefuck --alias | source
pyenv init - | source
