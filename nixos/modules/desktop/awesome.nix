{ inputs, config, pkgs, lib, ... }:

with lib;
let cfg = config.modules.desktop.awesome;
in
{
  options.modules.desktop.awesome = {
    enable = mkEnableOption "awesome";
  };

  config = mkIf cfg.enable {
    home.file = {
      ".config/awesome" = {
        recursive = true;
        source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dotfiles/config/awesome";
      };
      "dotfiles/config/awesome/modules/bling".source = inputs.bling.outPath;
      "dotfiles/config/awesome/modules/rubato".source = inputs.rubato.outPath;
    };
  };
}
