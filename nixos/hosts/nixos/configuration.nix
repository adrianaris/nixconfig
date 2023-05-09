# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  # Default editor
  programs.neovim.defaultEditor = true;
 
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # NTFS support
  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/Brussels";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  # networking.useDHCP = false;
  # networking.interfaces.enp7s0.useDHCP = true;
  # networking.interfaces.wlp8s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking = {
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [ 3389 ];
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      dpi = 144;

      # Enable automatic login for the user.
      displayManager = {
        autoLogin.enable = true;
        autoLogin.user = "adrianaris";
        sddm.enable = true;
        defaultSession = "none+awesome";
      };

      # awesomewm

      windowManager.awesome = {
        enable = true;
        package = pkgs.awesome-git;
      };

      # Configure keymap in X11
      layout = "us";
    };

      # xkbOptions = "eurosign:e";
    avahi = {
      enable = true;
      nssmdns = true;
    };

    xrdp.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;

    plex = {
      enable = true;
      openFirewall = true;
    };
  };


  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  systemd.user.services = {
    pipewire.wantedBy = [ "default.target" ];
    pipewire-pulse = {
      path = [ pkgs.pulseaudio ];
      wantedBy = [ "default.target" ];
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.adrianaris = {
    isNormalUser = true;
    shell = pkgs.zsh;
    home = "/home/adrianaris";
    description = "Adrian Serbanescu";
    extraGroups = [ "wheel" "networkmanager" "docker" "plex"  "libvirtd" ];
  };

  users.users.remotessh = {
    isNormalUser = true;
    shell = pkgs.zsh;
    home = "/home/remotessh";
    description = "pair programming";
    openssh.authorizedKeys.keys = ["ssh-ed25519AAAAC3NzaC1lZDI1NTE5AAAAIFJRqDBfU5qgMNqjO8JHyOfOy5k28ngKNQoE8/xHMfNM remotessh@nixos"];
  };

  environment.binsh = "${pkgs.dash}/bin/dash";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    home-manager
    (import ./scripts/adjustDisplay.nix)
    (import ./scripts/updateNixosConfig.nix)
    (import ./scripts/updateCodeExtensions.nix)

    gnumake
    wget 
    alacritty
    tmux
    sshfs
    neovim-remote
    google-chrome
    python3
    gcc
    glibc
    postman
    curl
    jq # format json output
    emacs
    fzf
    fzf-zsh
    silver-searcher
    git
    sqlite
    okular
    qimgv
    obs-studio
    neofetch
    nnn
    weechat
    vlc
    scrot
    discord
    gzip
    unzip
    spotify
    qbittorrent
    zip
    xclip
    magic-wormhole
    zathura

    # systemwide python packages
    # (python38.withPackages(ps: with ps; [ numpy toolz]))
  ];

  nix = {
    package = pkgs.nixUnstable;
    settings.trusted-users = [ "root" "adrianaris" ];
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  fonts.fonts = with pkgs; [
    powerline-fonts
    inconsolata
    cascadia-code
    ibm-plex
    (nerdfonts.override { fonts = [ "CascadiaCode" "FiraCode" "Iosevka" "JetBrainsMono" ]; })
    noto-fonts-emoji-blob-bin
  ];

  fonts.fontconfig = {
    defaultFonts = {
      monospace = [ "Cascadia Code" ];
      sansSerif = [ "Cascadia Code" ];
      serif = [ "Cascadia Code" ];
      emoji = [ "Blobmoji" ];
    };
  };

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";

    # nnn config
    NNN_FIFO = "/tmp/nnn.fifo";
    NNN_PLUG = "p:preview-tui;s:suedit";

    # nix path-info doest work on unfree without
    NIXPKGS_ALLOW_UNFREE="1";
  };

  environment.sessionVariables = rec {
    XDG_CACHE_HOME = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_BIN_HOME = "\${HOME}/.local/bin";
    XDG_DATA_HOME = "\${HOME}/.local/share";

    PATH = [
      "\${HOME}/.bin"
      "\${XDG_BIN_HOME}"
      "\${HOME}/.node_modules"
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs = {
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    # zsh default
    zsh.enable = true;
    zsh.ohMyZsh.customPkgs = [
      pkgs.nix-zsh-completions
      # and even more...
    ];

    # oh-my-zsh config
    zsh.ohMyZsh = {
      enable = true;
      plugins = [ "git" "python" "man" ];
      theme = "agnoster";
    };

    java.enable = true;
  };

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
  system.stateVersion = "23.05"; # Did you read the comment?

  # AUTO Upgrades
  # system.autoUpgrade.enable = true;
  # system.autoUpgrade.allowReboot = true;
  # system.autoUpgrade.channel = https://channels.nixos.org/nixos-unstable;

  nixpkgs.config.allowUnfree = true; 

  services.tor.enable = true;

  virtualisation = {
    libvirtd.enable = true;
    docker = {
      enable = true;
      enableOnBoot = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };
}
