# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  lib,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    <home-manager/nixos>
    <catppuccin/modules/nixos>
    ./home/default.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["ntfs"];

  boot.initrd.luks.devices."luks-72a3ccb0-f0a2-4983-a010-acebbc7b9b0a".device = "/dev/disk/by-uuid/72a3ccb0-f0a2-4983-a010-acebbc7b9b0a";
  networking.hostName = "helloworld"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.nameservers = ["8.8.8.8" "8.8.4.4"];

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

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

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
    extraGroups = ["networkmanager" "wheel" "docker"];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    xclip
    xdotool
    xsel
    xcolor
    xdo
    xtitle
    xorg.xev
    blueman
    zip
    unzip
    gcc
    gnumake
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["SourceCodePro" "D2Coding"];})
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
    dates = "monthly";
    options = "--delete-older-than 30d";
  };

  system.autoUpgrade = {
    enable = true;
    dates = "monthly";
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
  catppuccin.flavor = "mocha";

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  virtualisation.docker.enable = true;

  services.flatpak.enable = true;
  xdg.portal.enable = true;

  services.syncthing = {
    enable = true;
    user = "dkostmii";
    configDir = "/home/dkostmii/.config/syncthing";
    dataDir = "/home/dkostmii/.config/syncthing/data";
    overrideDevices = true; # overrides any devices added or deleted through the WebUI
    overrideFolders = true; # overrides any folders added or deleted through the WebUI
    settings = {
      gui = (
        let
          # Function to read a file, take the first line, and trim it
          readFirstLineTrimmed = filePath: let
            # Reading the file content as a string
            fileContent = builtins.readFile filePath;

            # Splitting the file content into lines and taking the first line
            firstLine = builtins.head (lib.strings.splitString "\n" fileContent);

            # Trimming the first line
            trimmedFirstLine = builtins.replaceStrings [" " "\n" "\r" "\t"] ["" "" "" ""] firstLine;
          in
            trimmedFirstLine;
        in {
          user = readFirstLineTrimmed ./.secrets/syncthing/username;
          password = readFirstLineTrimmed ./.secrets/syncthing/password;
        }
      );
      devices = {
        "phone" = {id = "EJZFBO2-JTDQTMC-ORW55WG-Z6L4RO2-RM6PDI6-4HLLOEJ-HAATCQN-OTAIXA4";};
      };
      folders = {
        "9qjcl-fuhjb" = {
          label = "Books"; # Optional label for the folder
          path = "/home/dkostmii/Документи/Books";
          devices = ["phone"];
          ignorePerms = false; # By default, Syncthing doesn't sync file permissions. This line enables it for this folder.
        };
      };
    };
  };

  users.extraGroups.vboxusers.members = ["dkostmii"];

  virtualisation.virtualbox = {
    host.enable = true;
    guest.enable = true;
    guest.draganddrop = true;
  };

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
