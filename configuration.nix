# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
      <catppuccin/modules/nixos>
      ./home/default.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  boot.initrd.luks.devices."luks-72a3ccb0-f0a2-4983-a010-acebbc7b9b0a".device = "/dev/disk/by-uuid/72a3ccb0-f0a2-4983-a010-acebbc7b9b0a";
  networking.hostName = "helloworld"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.nameservers = [ "8.8.8.8" "8.8.4.4" ];

  # Set your time zone.
  time.timeZone = "Europe/Kyiv";

  # Select internationalisation properties.
  i18n.defaultLocale = "uk_UA.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "uk_UA.UTF-8";
    LC_IDENTIFICATION = "uk_UA.UTF-8";
    LC_MEASUREMENT = "uk_UA.UTF-8";
    LC_MONETARY = "uk_UA.UTF-8";
    LC_NAME = "uk_UA.UTF-8";
    LC_NUMERIC = "uk_UA.UTF-8";
    LC_PAPER = "uk_UA.UTF-8";
    LC_TELEPHONE = "uk_UA.UTF-8";
    LC_TIME = "uk_UA.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us,ua";
    xkb.variant = "";
    xkb.options = "grp:alt_shift_toggle";
  };

  # Configure console keymap
  console.keyMap = "ua-utf";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dkostmii = {
    isNormalUser = true;
    description = "Dmytro-Andrii Kostelnyi";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
     xdg-desktop-portal-gtk
     xclip
     xdotool
     xsel
     xcolor
     xdo
     xtitle
     xorg.xev
     blueman
     xfce.catfish
     xfce.gigolo
     xfce.orage
     xfce.xfburn
     xfce.xfce4-appfinder
     xfce.xfce4-clipman-plugin
     xfce.xfce4-cpugraph-plugin
     xfce.xfce4-dict
     xfce.xfce4-fsguard-plugin
     xfce.xfce4-genmon-plugin
     xfce.xfce4-netload-plugin
     xfce.xfce4-panel
     xfce.xfce4-pulseaudio-plugin
     xfce.xfce4-systemload-plugin
     xfce.xfce4-weather-plugin
     xfce.xfce4-whiskermenu-plugin
     xfce.xfce4-xkb-plugin
     xfce.xfdashboard
     zip
     unzip
     gcc
     gnumake
  ];

  fonts.packages = with pkgs; [
     (nerdfonts.override { fonts = [ "SourceCodePro" "D2Coding" ]; })
     cantarell-fonts
     d2coding
     source-code-pro
     corefonts
     aileron
  ];

  fonts.fontconfig = {
    localConf = ''
      <!-- use a less horrible font substition for pdfs such as https://www.bkent.net/Doc/mdarchiv.pdf -->
      <match target="pattern">
        <test qual="any" name="family"><string>Helvetica</string></test>
        <edit name="family" mode="assign" binding="same"><string>Aileron</string></edit>
      </match>
    '';
  };

  fonts.fontDir.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Nix store optimizations
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "Sat 10:00";
    options = "--delete-older-than 7d";
  };

  system.autoUpgrade = {
    enable = true;
    dates = "Sun 10:00";
    allowReboot = false;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.neovim.enable = true;

  catppuccin.enable = true;
  catppuccin.flavor = "latte";
  catppuccin.accent = "pink";

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  virtualisation.docker.enable = true;

  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
