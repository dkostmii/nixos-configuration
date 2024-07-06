{ config, pkgs, ... }:

let
  catppuccin-theme-xfce4-terminal = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "xfce4-terminal";
    rev = "6d35252aeec1cf07aa211071324498c9e52b5378";
    sha256 = "sha256-Bhl/U5Tn/Y5gPP8aWuygckdhBXgn7KmCxj/Cgq/C3jU=";
  };
in
{
  home-manager.users.dkostmii = { pkgs, ... }: {
    imports = [
      <catppuccin/modules/home-manager>
      ./nvim/default.nix
    ];
    
    nixpkgs.config.allowUnfree = true;

    home.file.".local/share/xfce4/terminal/colorschemes/catppuccin-latte.theme" = {
      source = "${catppuccin-theme-xfce4-terminal}/themes/catppuccin-latte.theme";
    };

    catppuccin.enable = true;
    catppuccin.flavor = "latte";

    gtk = {
      enable = true;
      catppuccin = {
        enable = true;
        flavor = "latte";
        accent = "pink";
        size = "standard";
        tweaks = [ "normal" ];
      };
    };

    programs.bash.enable = true;

    programs.fish = {
      enable = true;
      plugins = [
        {
          name = "pass-fish-completion";
          src = ./fish/pass-completions;
        }
      ];
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
