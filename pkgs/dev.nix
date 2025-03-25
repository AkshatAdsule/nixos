{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Enable docker
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # postgres
  services.postgresql = {
    enable = true;
    authentication = pkgs.lib.mkOverride 10 ''
      #type database DBuser origin-address auth-method
      local all       all     trust
      # ipv4
      host  all      all     127.0.0.1/32   trust
      # ipv6
      host all       all     ::1/128        trust
    '';
  };

  # Packages for development
  environment.systemPackages = with pkgs; [
    # Shell utilities
    git
    vim
    neovim
    fzf
    unzip
    ripgrep
    fd
    bat
    file
    lazygit
    ghostty
    inotify-tools
    # IDEs
    vscode
    helix

    # SSH
    keychain

    # [nix]
    nil
    nixpkgs-fmt
    alejandra
    libnotify

    # [C/C++] Development
    gcc
    glibc
    gnumake
    autoconf
    automake
    libtool
    llvmPackages_19.clang-unwrapped

    gmp
    gmp.dev
    isl
    libffi
    libffi.dev
    libmpc
    libxcrypt
    mpfr
    mpfr.dev
    xz
    xz.dev
    zlib
    zlib.dev

    m4
    bison
    flex
    texinfo

    valgrind

    # [js]
    bun
    nodejs_23
    corepack_latest

    # [ECS 171]
    uv
    devenv

    # [go]
    go

    # [elixir]
    elixir
    erlang
    elixir-ls
  ];
}
