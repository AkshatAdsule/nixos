{config, pkgs, inputs} : 

# Packages for development
{
  environment.systemPackages = with pkgs; [
    git
    vim
    neovim

    # build-esstential
    gcc
    glibc
    make
    cmake
    autoconf
    automake
    libtool
    llvmPackages_19.clang-unwrapped
  ];
}