# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./vim.nix
      ./vscode.nix
    ];
  
  # Default editor
  programs.neovim.defaultEditor = true;
 
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # NTFS support
  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp7s0.useDHCP = true;
  # networking.interfaces.wlp8s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "startplasma-x11";
  networking.firewall.allowedTCPPorts = [ 3389 ];

  services.xserver.videoDrivers = [ "nvidia" ];

  # Enable the Plasma 5 Desktop Environment.
  services.xserver = {
    dpi = 144;
    displayManager = {
      sddm.enable = true;
    };
    desktopManager.plasma5.enable = true;
  };
  
  environment.variables = {
    GDK_SCALE="2";
    GDK_DPI_SCALE="0.5";
  };

  hardware.video.hidpi.enable = true;

  # # xfce
  # services.xserver.desktopManager.xterm.enable = false;
  # services.xserver.desktopManager.xfce.enable = true;
  # services.xserver.displayManager.defaultSession = "xfce";

  # # i3 window manager
  # services.xserver.autorun = false;
  # # services.xserver.desktopManager.default = "none";
  # services.xserver.desktopManager.xterm.enable = false;
  # services.xserver.displayManager.lightdm.enable = true;
  # services.xserver.windowManager.i3.enable = true;

  # Configure keymap in X11
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.adrianaris = {
    isNormalUser = true;
    shell = pkgs.zsh;
    home = "/home/adrianaris";
    description = "Adrian Serbanescu";
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget 
    tmux
    firefox
    google-chrome
    python3
    gcc
    glibc
    gtk3
    postman
    nodejs-16_x
    curl
    jq # format json output
    emacs
    zsh
    fzf
    fzf-zsh
    oh-my-zsh
    silver-searcher
    nix-zsh-completions
    git
    sqlite
    heroku
    docker
    libreoffice
    okular
    qimgv
    obs-studio
    neofetch
    ranger
    irssi
    weechat
    vlc
    scrot
    discord
    jdk17
    maven
    spring-boot
    spring-boot-cli
    tomcat9
    idea.idea-community
    gzip
    unzip
    zoom-us
    spotify
    qbittorrent
    zip
    teamviewer
    xclip

    cypress
    # for cypress
    xorg.libXScrnSaver
    xorg.libXdamage
    xorg.libX11
    xorg.libxcb
    xorg.libXcomposite
    xorg.libXi
    xorg.libXext
    xorg.libXfixes
    xorg.libXcursor
    xorg.libXrender
    xorg.libXrandr
    mesa
    cups
    expat
    ffmpeg
    libdrm
    libxkbcommon
    at_spi2_atk
    at_spi2_core
    dbus
    gdk_pixbuf
    gtk3
    cairo
    pango
    xorg.xauth
    glib
    nspr
    atk
    nss
    gtk2
    alsaLib
    gnome2.GConf
    unzip
    (lib.getLib udev)
    # ^ for cypress

    # systemwide python packages
    # (python38.withPackages(ps: with ps; [ numpy toolz]))

    (import ./scripts/updateNixosConfig.nix)
  ];

  fonts.fonts = with pkgs; [
    inconsolata
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # zsh default
  programs.zsh.enable = true;
  programs.zsh.ohMyZsh.customPkgs = [
    pkgs.nix-zsh-completions
    # and even more...
  ];
  # oh-my-zsh config
  programs.zsh.ohMyZsh = {
    enable = true;
    plugins = [ "git" "python" "man" ];
    theme = "agnoster";
  };

  programs.java.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;
  # networking.networkmanager.enable = true;
  # networking.wireless.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

  # AUTO Upgrades
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  system.autoUpgrade.channel = https://nixos.org/channels/nixos-21.11;

  nixpkgs.config.allowUnfree = true; 

}
