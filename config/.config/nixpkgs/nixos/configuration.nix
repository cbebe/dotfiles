{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz";
  home-config = import ../home.nix;
  xkbConfig = {
    layout = "us,real-prog-dvorak";
    options = "grp:win_space_toggle,ctrl:swapcaps";
    realProgDvorak = {
      description = "Michael Paulson's Programmer's Dvorak";
      languages = [ "eng" ];
      symbolsFile = /home/chrlz/.dotfiles/symbols/real-prog-dvorak;
    };
  };
in {
  imports = [
    ./hardware-configuration.nix
    (import "${home-manager}/nixos")
    (import ./sway.nix xkbConfig)
    # (import ./awesome.nix xkbConfig)
  ];

  home-manager.users.chrlz = home-config;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  networking.nameservers = [ "1.1.1.1" "9.9.9.9" ];
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable =
    true; # Easiest to use and most distros use this by default.
  programs.nm-applet.enable = true;

  # Transparency
  services.picom.enable = true;

  # Set your time zone.
  time.timeZone = "America/Edmonton";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  fonts.fonts = with pkgs;
    [ (nerdfonts.override { fonts = [ "IBMPlexMono" ]; }) ];
  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  # hardware.pulseaudio.enable = true;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.chrlz = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      zlib
      qutebrowser
      xclip
      xsel
      sxiv
      kitty
      signal-desktop
      neovim
      libnotify
      sshfs
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gcc
    wget
    (retroarch.override { cores = with libretro; [ snes9x ]; })
    libretro.snes9x
  ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # xdg-desktop-portal works by exposing a series of D-Bus interfaces
  # known as portals under a well-known name
  # (org.freedesktop.portal.Desktop) and object path
  # (/org/freedesktop/portal/desktop).
  # The portal interfaces include APIs for file access, opening URIs,
  # printing and others.
  services.dbus.enable = true;

  # Backlight adjustment
  services.illum.enable = true;

  # Use doas
  security.sudo.enable = false;
  security.doas = {
    enable = true;
    extraRules = [{
      users = [ "chrlz" ];
      persist = true;
      keepEnv = true;
    }];
  };

  # Nix configuration
  nix = {
    autoOptimiseStore = true;
    nixPath = [
      "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
      "nixos-config=/home/chrlz/.config/nixpkgs/nixos/configuration.nix"
      "/nix/var/nix/profiles/per-user/root/channels"
    ];
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    permitRootLogin = "no";
    ports = [ 8069 ];
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 8069 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
