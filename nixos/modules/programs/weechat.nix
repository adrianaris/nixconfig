{ config, pkgs, lib, ... }:

{
  programs.weechat = {
    enable = true;
    package = pkgs.weechat;
  };
}

