with import <nixpkgs> {};

writeShellScriptBin "updateNixosConfig.sh" ''
  #!/bin/sh
  rm -rf ~/nixconfig/nixos/
  cp -r /etc/nixos/ ~/nixconfig
  rm ~/nixconfig/nixos/hardware-configuration.nix
''
