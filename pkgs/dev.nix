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
