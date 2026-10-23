{ config, pkgs, user, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
in

{
  home.username = user;
  home.homeDirectory = "/Users/${user}";
  home.stateVersion = "24.11";
  home.packages = with pkgs; [
    # cli i use constantly
    ripgrep   # fast search
    fd        # fast find
    fzf       # fuzzy finder
    jq        # json on the command line
    lazygit
    neovim
    # the font everything renders in
    nerd-fonts.hack
    noto-fonts-cjk-sans
  ];
  fonts.fontconfig.enable = true;
  home.sessionVariables = {
    EDITOR = "nvim";
    HOMEBREW_NO_AUTO_UPDATE = "1";
    # QODER_EXPOSE_TOKEN_USAGE = "1";
    # QODERCN_EXPOSE_TOKEN_USAGE = "1";
  };

  home.sessionPath = [
    # "/opt/homebrew/opt/openssl/bin"
    # uv and other util CLIs
    #"${config.home.homeDirectory}/.local/bin"
    #"${config.home.homeDirectory}/Library/pnpm"
    #"${config.home.homeDirectory}/go/bin"
    #"${config.home.homeDirectory}/.r2c/bin"
  ];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;      # ghost text from history
    syntaxHighlighting.enable = true;  # commands turn green when valid

    shellAliases = {
      ".." = "cd ..";
      add = "git add .";
      push = "git push";
      pull = "git pull";
      m = "git switch main";
      ll = "ls -al";
      #java-17 = "export JAVA_HOME=$(/usr/libexec/java_home -v 17); java -version";
      #java-8 = "export JAVA_HOME=$(/usr/libexec/java_home -v 1.8); java -version";
    };

    initContent = ''
      bindkey '^f' autosuggest-accept

      # NVM
      #export NVM_DIR="${config.home.homeDirectory}/.nvm"
      #[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
      #[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = "$directory$git_branch$git_status$cmd_duration$line_break$character";
      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
      };
      cmd_duration.format = "[$duration]($style) ";
    };
  };
  # Edit-in-place: the real file stays in my repo, ~/.config just points at it.
  home.file.".config/wezterm".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/wezterm";
  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/nvim";
  home.file.".config/herdr".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/herdr";
  # home.file.".qoder/settings.json".source =
  #   config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.qoder/settings.json";

}
