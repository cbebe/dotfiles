{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz";
  home-config = import ../home.nix;
in {
  imports = [ (import "${home-manager}/nix-darwin") ];

  # Bless this man
  # https://git.bytes.zone/brian/dotfiles.nix/src/commit/dd1633e69c90eb6fd9cb8c408488dc24ab76931b/notes/home-manager-with-nix-darwin.org
  users.users.chrlz.name = "chrlz";
  users.users.chrlz.home = "/Users/chrlz";
  home-manager.users.chrlz = home-config;

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [ pkgs.vim ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
