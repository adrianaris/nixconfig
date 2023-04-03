
{ config, pkgs, libs, ... }:
{
  imports = [
    ./kitty
    ./ncmpcpp.nix
  ];
  home.packages = with pkgs; [ brave rofi ];
  home.file.".config/rofi" = {
    recursive = true;
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/rofi";
  };
}

