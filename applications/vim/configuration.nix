{ pkgs, ... }:
{
  # to understand:
  # - nix flakes # this is experimental feature. i'm not going to use it
  # - lsp

  # to do nix vim with:
  # - telescope to navigate
  # - C# omnisharp lsp
  # - add global find with '/'
  # - restrict telescope and global find scope to project directory 

  # optional to add:
  # - go to implementation
  # - go to reference

  environment.systemPackages = with pkgs; [
    # ((vim_configurable.override {  }).customize{
    #   name = "vim";
    #   # Install plugins for example for syntax highlighting of nix files
    #   vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
    #     start = [ vim-nix vim-lastplace ];
    #     opt = [];
    #   };
    #   vimrcConfig.customRC = ''
    #     syntax on

    #     set relativenumber

    #     " copy and paste without "+ before "+y or "+p
    #     set clipboard=unnamedplus


    #     set viminfo=""

    #     " tabs config
    #     set expandtab
    #     set autoindent
    #     set smartindent
    #   '';
    # })
    neovim
    # xclip  # For X11 users
    wl-clipboard  # For Wayland users
    ripgrep
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    configure = {
      customRC = ''
      lua << EOF
      dofile('/etc/nixos/applications/vim/lua/init.lua')
      EOF
      '';
    };
  };
}