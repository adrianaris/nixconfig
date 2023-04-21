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
      version = "0.84.0";
      sha256 = "0rw2klz1f4sy1xzwg4bilcm2sjk0lxdfh9ly3f4kbl8a5xccfy6z";
    }
    {
      name = "vscode-typescript-next";
      publisher = "ms-vscode";
      version = "5.1.20230418";
      sha256 = "1pk5caf5q3nhg79xyr5yvxi50prpi7ninay54z9ipj05csldm6fr";
    }
    {
      name = "rest-client";
      publisher = "humao";
      version = "0.25.1";
      sha256 = "19yc3hvhyr2na741z6ajgigxckagvfrcq3h6y958bl4107vxjb0d";
    }
    {
      name = "vscode-neovim";
      publisher = "asvetliakov";
      version = "0.0.97";
      sha256 = "1z5vqvbgk6pn0li265mi0r28q4ir7wzd508q9sii933pc3qrdldc";
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

