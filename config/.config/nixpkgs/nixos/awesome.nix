xkbConfig:
{ config, pkgs, ... }:
let
  # Not sure how I'd do this tbh
  myNixPkgsFork = import
    (builtins.fetchTarball "https://github.com/cbebe/nixpkgs/tarball/master")
    # reuse the current configuration
    { config = config.nixpkgs.config; };
in {
  services.xserver = {
    enable = true;
    layout = xkbConfig.layout;
    xkbOptions = xkbConfig.options;
    libinput.enable = true;
    displayManager.sddm = {
      enable = true;
      setupScript = builtins.readFile (../../zsh/.envrc);
    };
    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [ luarocks ];
    };
    extraLayouts.real-prog-dvorak = xkbConfig.realProgDvorak;
  };
}
