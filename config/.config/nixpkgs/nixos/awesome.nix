xkbConfig:
{ config, pkgs, ... }: {
  services.xserver = {
    enable = true;
    layout = xkbConfig.layout;
    xkbOptions = xkbConfig.options;
    libinput.enable = true;
    displayManager.sddm.enable = true;
    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [ luarocks ];
    };
    extraLayouts.real-prog-dvorak = xkbConfig.realProgDvorak;
  };
}
