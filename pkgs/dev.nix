{config, pkgs, inputs, ...} : 

# Packages for development
{
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

    # IDEs
    vscode

    # SSH
    keychain

    # [C/C++] Development
    gcc
    glibc
    gnumake
    autoconf
    automake
    libtool
    llvmPackages_19.clang-unwrapped

    gmp gmp.dev
    isl
    libffi libffi.dev
    libmpc
    libxcrypt
    mpfr mpfr.dev
    xz xz.dev
    zlib zlib.dev

    m4
    bison
    flex
    texinfo

    valgrind
  ];
}
