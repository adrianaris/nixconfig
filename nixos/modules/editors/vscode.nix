{ pkgs,config, lib, ... }:

with lib;
let
  cfg = config.modules.editors.vscode;

in {
  options.modules.editors.vscode = {
    enable = mkEnableOption "vscode";
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        (import ./vscodeextensions.nix).extensions
      ];
    };
  };
}

