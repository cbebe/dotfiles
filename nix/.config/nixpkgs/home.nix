{ config, pkgs, ... }:
let
  machine = import ./machine.nix;
  isLinux = machine.operatingSystem == "Linux";
  isDarwin = machine.operatingSystem == "Darwin";
  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-basic
      # Just the necessary packages to compile my Resume
      marvosym
      metafont
      preprint
      enumitem
      fancyhdr
      titlesec;
  });
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "chrlz";
  home.homeDirectory = (
    if isLinux then "/home/chrlz"
    else if isDarwin then "/Users/chrlz"
    else throw "Unknown operating system"
  );

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    neovim
    tex
    gnupg
    stow
    gh
  ];

  programs.bat = {
    enable = true;
    config = {
      italic-text = "always";
    };
  };
}
