{ pkgs, ... }:

let
  catppuccin-theme-xfce4-terminal = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "xfce4-terminal";
    rev = "6d35252aeec1cf07aa211071324498c9e52b5378";
    sha256 = "sha256-Bhl/U5Tn/Y5gPP8aWuygckdhBXgn7KmCxj/Cgq/C3jU=";
  };
  catppuccin-gtk-theme = pkgs.stdenv.mkDerivation {
    pname = "catppuccin-mocha-blue-standard+default.zip";
    version = "1.0.3";
    buildInputs = with pkgs; [ unzip ];

    src = pkgs.fetchurl {
      url = "https://github.com/catppuccin/gtk/releases/download/v1.0.3/catppuccin-mocha-blue-standard+default.zip";
      sha256 = "sha256-g4EQUczrMmI/r95BE1AYgEY3DXPudGS7Jihc1jx1O9w=";
    };

    sourceRoot = ".";

    buildPhase = ''
      unzip $src -d $out
    '';

    meta = with pkgs.lib; {
      description = "Catppuccin GTK theme with mocha preset, blue accent and standard + default";
      license = licenses.gpl3Only;
      platforms = platforms.all;
      homepage = "https://github.com/catppuccin/gtk";
    };
  };
in
{
  home-manager.users.dkostmii = { config, pkgs, ... }: {
    imports = [
      <catppuccin/modules/home-manager>
      ./nvim/default.nix
    ];

    nixpkgs.config.allowUnfree = true;

    home.packages = with pkgs; [
      gimp
      libreoffice
      nodejs_22
      python3
      hyfetch
      pamixer
      pavucontrol
      papirus-icon-theme
      lazydocker
      blugon
      glow
    ];

    home.file.".local/share/xfce4/terminal/colorschemes/catppuccin-mocha.theme" = {
      source = "${catppuccin-theme-xfce4-terminal}/themes/catppuccin-mocha.theme";
    };

    xdg.configFile."gtk-3.0/settings.ini" = {
      text = builtins.readFile(./gtk/shared/settings.ini);
    };

    xdg.configFile."gtk-4.0/settings.ini" = {
      text = builtins.readFile(./gtk/shared/settings.ini);
    };

    xdg.configFile."gtk-3.0" = {
      source = "${catppuccin-gtk-theme}/catppuccin-mocha-blue-standard+default/gtk-3.0";
      recursive = true;
    };

    xdg.configFile."gtk-4.0" = {
      source = "${catppuccin-gtk-theme}/catppuccin-mocha-blue-standard+default/gtk-4.0";
      recursive = true;
    };

    home.file.".local/share/themes/catppuccin-mocha-blue-standard+default" = {
      source = config.lib.file.mkOutOfStoreSymlink "${catppuccin-gtk-theme}/catppuccin-mocha-blue-standard+default";
    };

    home.file.".themes/catppuccin-mocha-blue-standard+default" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.local/share/themes/catppuccin-mocha-blue-standard+default";
    };

    home.file.".local/share/icons/Papirus" = {
      source = config.lib.file.mkOutOfStoreSymlink "${pkgs.papirus-icon-theme}/share/icons/Papirus";
    };

    home.file.".icons/Papirus" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.local/share/icons/Papirus";
    };

    home.file.".local/share/icons/Papirus-Light" = {
      source = config.lib.file.mkOutOfStoreSymlink "${pkgs.papirus-icon-theme}/share/icons/Papirus-Light";
    };

    home.file.".icons/Papirus-Light" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.local/share/icons/Papirus-Light";
    };

    programs.password-store = {
      enable = true;
      settings = {
        PASSWORD_STORE_DIR = "${config.home.homeDirectory}/.password-store";
      };
    };

    catppuccin = {
      enable = true;
      flavor = "mocha";
    };

    programs.bash.enable = true;

    programs.fish = {
      enable = true;
      plugins = [
        {
          name = "pass-fish-completion";
          src = ./fish/pass-completions;
        }
        {
          name = "nix-shell-prompt-indicator";
          src = ./fish/nix-shell-prompt-indicator;
        }
      ];
    };

    programs.tmux = {
      enable = true;
      shell = "${pkgs.fish}/bin/fish";
      mouse = true;
      clock24 = true;
    };

    programs.git = {
      enable = true;
      aliases = {
        lg1 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all";
        lg2 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
        lg = "lg1";
      };

      userName = "Dmytro-Andrii Kostelnyi";
      userEmail = "dmitrokostelny95@gmail.com";
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
      };
    };

    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      options = [ "--hook" "pwd" "--cmd" "cd"];
    };

    programs.fzf = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };

    programs.ripgrep.enable = true;

    programs.hyfetch = {
      enable = true;
      settings = {
        preset = "rainbow";
        mode = "rgb";
        color_align = {
          mode = "horizontal";
        };
      };
    };

    programs.lazygit.enable = true;
    programs.btop.enable = true;
    programs.bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [ batdiff batman batgrep batwatch ];
    };

    programs.eza = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };

    home.stateVersion = "24.05";
  };
}
