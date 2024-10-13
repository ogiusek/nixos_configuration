{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
  ];

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    # displayManager.gdm.wayland = false;
    desktopManager = {
      gnome.enable = true;
      gnome.extraGSettingsOverrides = ''
        [org.gnome.desktop.wm.preferences]
        button-layout=":minimize,maximize,close"

        [org.gnome.desktop.wm.keybindings]
        switch-applications=[] 
        switch-windows=['<Alt>Tab', '<Super>Tab']
      '';
    };
    
  };
}