{ config, pkgs, ... }:
# let
#   dotnet-combined = (with pkgs.dotnetCorePackages; combinePackages [
#     sdk_8_0
#     aspnetcore_8_0
#   ]).overrideAttrs (finalAttrs: previousAttrs: {
#     # This is needed to install workload in $HOME
#     # https://discourse.nixos.org/t/dotnet-maui-workload/20370/2

#     postBuild = (previousAttrs.postBuild or '''') + ''
#        for i in $out/sdk/*
#        do
#          i=$(basename $i)
#          length=$(printf "%s" "$i" | wc -c)
#          substring=$(printf "%s" "$i" | cut -c 1-$(expr $length - 2))
#          i="$substring""00"
#          mkdir -p $out/metadata/workloads/''${i/-*}
#          touch $out/metadata/workloads/''${i/-*}/userlocal
#       done
#     '';
#   });
# in
{
  # config
  imports =
    [
      ./hardware-configuration.nix
      ./machine-configuration.nix
      # ./shell.nix

      ./scripts/scripts.nix
      ./applications/vim/configuration.nix
    ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  # nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    # dotnet-combined
    dotnetCorePackages.sdk_6_0
    # dotnetCorePackages.aspnetcore_6_0
    dotnetCorePackages.sdk_8_0
    dotnetCorePackages.aspnetcore_8_0
    nodejs_20


    openssh
    pkgs.gnome3.gnome-tweaks
    docker
    git
    wget
    vscode
    unzip
  ];

  virtualisation.docker.enable = true;

  programs.firefox.enable = true;
}
