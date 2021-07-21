{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "matteo";
  home.homeDirectory = "/Users/matteo";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";

  programs.fish = {
    enable = true;

    shellAbbrs = {
      l = "ls -lh";
      chmox = "chmod +x";
      v = "vim";
      d = "date";
      t = "watson";
      tl = "watson log -c";
      gl = "git log";
      gg = "git log --all --graph --oneline";
      gh = "git show HEAD";
      gs = "git status";
      gd = "git diff";
      gD = "git diff --staged";
      ga = "git add";
      gc = "git checkout";
      gC = "git commit";
      gCa = "git commit --amend";
      gCan = "git commit --amend --no-edit";
      gM = "git merge";
      gf = "git fetch --all";
      gp = "git pull";
      gP = "git push";
      gPu = "git push -u origin HEAD";
      gPf = "git push --force-with-lease";
    };

    shellAliases = {
      tree = "exa -T -I='__pycache__|node_modules'";
      vim = "nvim";
    };

    promptInit = ''
      function fish_prompt --description 'Write out the prompt'
          set_color $fish_color_cwd
          echo -n (prompt_pwd)

          set -l branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)
          if test -n "$branch"
              set_color $fish_color_escape
              echo -n " ($branch)"
          end

          echo
          set_color --bold normal
          echo -n '$ '
          set_color normal
      end
    '';

    loginShellInit = ''
      set -U fish_features stderr-nocaret qmark-noglob

      fish_add_path ~/bin ~/go/bin ~/.cargo/bin ~/.local/bin ~/.poetry/bin /usr/local/opt/libpq/bin
      set -xU LC_ALL en_US.UTF-8
      set -xU LC_CTYPE en_US.UTF-8


      if type -q direnv; eval (direnv hook fish); end
      if type -q pyenv; pyenv init - --no-rehash | source; end
    '';

    interactiveShellInit = ''
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
    '';
  };
}
