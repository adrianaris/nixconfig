with import <nixpkgs> {};

writeShellScriptBin "updateNixosConfig.sh" ''
  #!/bin/sh
  rm -rf ~/nixconfig/nixos/
  cp -r /etc/nixos/ ~/nixconfig
  cd ~/nixconfig
  git add .
  git commit -m 'called updateNixosConfig script'
  git push origin awesome
''

