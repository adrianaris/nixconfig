{ config, pkgs, lib, ... }:
{
  imports = [
    ../../modules/programs
    ../../modules/desktop
    ../../modules/dev/clojure.nix
    ../../modules/dev/lua.nix
    ../../modules/dev/node.nix
    ../../modules/dev/rust.nix
    ../../modules/dev/nix.nix
    ../../modules/dev/python.nix
  ];

  config = {
    home = {
      username = "adrianaris";
      homeDirectory = "/home/adrianaris";
      stateVersion = "23.05";
    };
    modules = {
      desktop = {
        picom.enable = true;
        dunst.enable = true;
        awesome.enable = true;
        autorandr.enable = true;
      };
      programs = {
        kitty.enable = true;
      };
      dev = {
        clojure.enable = true;
        # lisp.enable = false;
        lua.enable = true;
        nix.enable = true;
        node.enable = true;
        python.enable = true;
        rust.enable = false;
      };
    };
  };
}
