{ pkgs, ... }:

let
  extensions = (with pkgs.vscode-extensions; [
      bbenoist.nix
      ms-python.python
      ms-azuretools.vscode-docker
      ms-vscode-remote.remote-ssh
    ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "remote-ssh-edit";
        publisher = "ms-vscode-remote";
        version = "0.70.0";
        sha256 = "15xllbzmiwvqz4sa60qhj77p69zx4mjnvgiw419xqdsm75g30xkk";
      }
      {
        name = "rest-client";
        publisher = "humao";
        version = "0.24.6";
        sha256 = "196pm7gv0488bpv1lklh8hpwmdqc4yimz389gad6nsna368m4m43";
      }
      {
        name = "vscode-typescript-next";
        publisher = "ms-vscode";
        version = "4.6.20220115";
        sha256 = "0sjvcj2pji4g2975kj5zf57pw5zxjx5w7nb3wfvjqq065ygfxp8m";
      }
      {
        name = "vscode-neovim";
        publisher = "asvetliakov";
        version = "0.0.83";
        sha256 = "1giybf12p0h0fm950w9bwvzdk77771zfkylrqs9h0lhbdzr92qbl";
      }
  ];
  vscode-with-extensions = pkgs.vscode-with-extensions.override {
      vscodeExtensions = extensions;
    };
in {
  config = {
    environment.systemPackages = [
      vscode-with-extensions
    ];
  };
}

