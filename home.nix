{
  config,
  pkgs,
  lib,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "akshat";
  home.homeDirectory = "/home/akshat";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    pkgs.oh-my-zsh
    pkgs.python312Full
    pkgs.python312Packages.requests
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    "./.config/nvim/" = {
      source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/nvim;
      recursive = true;
    };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/akshat/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # globally ignore shell.nix and default.nix
  programs.git.ignores = ["shell.nix" "default.nix"];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # ZSH configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;

    # Add custom Zsh settings
    initExtra = ''
      zstyle ':completion:*' completer _complete _ignored _approximate
      zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**'
      zstyle :compinstall filename '$HOME/.zshrc'

      autoload -Uz compinit
      compinit

      setopt autocd extendedglob notify
      bindkey -v

      # FZF-specific Zsh configuration
      export FZF_CTRL_T_COMMAND="fd --type f"
      export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always {} || cat {}'"
      export FZF_ALT_C_COMMAND="fd --type d"
      export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

      # vi mode settings
      VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
      VI_MODE_SET_CURSOR=true
    '';

    # Set up history file
    history = {
      path = "${config.home.homeDirectory}/.histfile";
      size = 1000; # Size of history in memory
      save = 1000; # Number of entries to save to the file
    };

    oh-my-zsh = {
      enable = true;
      theme = "eastwood";
      plugins = ["git" "vi-mode" "direnv"];
    };
  };

  # FZF configuration
  programs.fzf = {
    enable = true;

    # Customize the default command
    defaultCommand = "fd --type f --hidden --follow --exclude .git";

    # Add default options
    defaultOptions = [
      "--height 40%"
      "--border"
      "--preview 'bat --style=numbers --color=always --line-range :500 {} || cat {}'"
    ];

    # Configure the CTRL-T keybinding for file search
    fileWidgetCommand = "fd --type f";

    # Configure the ALT-C keybinding for directory navigation
    changeDirWidgetCommand = "fd --type d";

    # Configure the CTRL-R keybinding for history search
    historyWidgetOptions = ["--sort --exact"];

    # Enable Zsh integration
    enableZshIntegration = true;

    # Optional: Set up FZF color scheme
    colors = {
      bg = "#1e1e1e";
      "bg+" = "#2e2e2e";
      fg = "#d4d4d4";
      "fg+" = "#f1c40f";
    };

    # Enable tmux integration (optional)
    tmux = {
      enableShellIntegration = true;
    };
  };

  # Keychain configuration
  programs.keychain = {
    enable = true;
    keys = ["id_csif" "id_git"];
  };

  systemd.user = {
    services."kde-color-scheme" = {
      Unit.Description = "Set KDE color scheme based on time of day";
      Service = {
        ExecStart = "${pkgs.python312}/bin/python ${config.home.homeDirectory}/apply_colorscheme.py";
        Type = "oneshot";
      };
    };

    timers."kde-color-scheme" = {
      Unit = {
        Description = "Timer to change KDE color scheme every 15 minutes";
      };
      Timer = {
        OnCalendar = "*-*-* *:00,15,30,45:00"; # Runs at :00, :15, :30, and :45 of every hour
        Persistent = true;
      };
      Install = {
        WantedBy = ["timers.target"];
      };
    };
  };
}
