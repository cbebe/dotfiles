{ config, pkgs, ... }:
let
  machine = import ./machine.nix;
  isLinux = machine.operatingSystem == "Linux";
  isDarwin = machine.operatingSystem == "Darwin";
  username = "chrlz";
  directory = (if isLinux then
    "/home/${username}"
  else if isDarwin then
    "/Users/${username}"
  else
    throw "Unknown operating system");
in {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = username;
  home.homeDirectory = directory;

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
    wget
    gnupg # Git GPG signing
    stow # creating symlinks to .config and .local
    fzf # tmux-sessionizer
    fd # telescope.nvim
    ripgrep
    tmux
    neofetch
    du-dust
    ani-cli
    mpv
    htop
    btop
    bitwarden-cli
    python
    sumneko-lua-language-server
    nixfmt
    shfmt
    unzip
    luaformatter
    clang-tools
    zathura
    imagemagick
  ];

  programs.exa.enable = true;
  programs.gh = {
    enable = true;
    settings = { editor = "nvim"; };
  };
  programs.bat = {
    enable = true;
    config = { italic-text = "always"; };
  };
  programs.git = {
    enable = true;
    userName = "Charles Ancheta";
    userEmail = "55412395+cbebe@users.noreply.github.com";
    extraConfig = {
      core = { editor = "nvim"; };
      color = { ui = true; };
      init = { defaultBranch = "master"; };
      pull = { ff = "only"; };
      commit = { gpgSign = true; };
    };
    delta = {
      enable = true;
      options = {
        navigate = true;
        line-numbers = true;
      };
    };
  };
}
