xkbConfig:
{ config, pkgs, ... }: {
  services.xserver = {
    enable = true;
    layout = xkbConfig.layout;
    xkbVariant = xkbConfig.variant;
    xkbOptions = xkbConfig.options;
    libinput.enable = true;
    displayManager.sddm.enable = true;
    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [ luarocks ];
    };
  };
}
