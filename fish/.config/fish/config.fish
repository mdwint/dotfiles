set fish_greeting
set fish_color_user normal
set fish_color_cwd brblue
set -U fish_prompt_pwd_dir_length 0

function fish_right_prompt
end

set PATH ~/bin ~/.cargo/bin ~/.poetry/bin $PATH

set -xU FZF_DEFAULT_COMMAND 'ag --nocolor --ignore node_modules -g ""'
set -xU MANPAGER 'most -wd'

alias l 'exa -l'
alias tree "exa -T -I='__pycache__|node_modules'"
alias vim nvim

direnv hook fish | source
thefuck --alias | source
pyenv init - | source
