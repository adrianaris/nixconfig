{
  description = "git push origin nixos config";

  outputs =  { self, nixpkgs }: {
    defaultPackage.x86_64-linux = self.packages.x86_64-linux.updateNixosConfig;

    packages.x86_64-linux.updateNixosConfig =
      let
        pkgs = import nixpkgs { system = "x86_64-linux"; };
      in
      pkgs.writeShellScriptBin "updateNixosConfig" ''
        #!/bin/sh
        rm -rf ~/nixconfig/nixos/
        cp -r /etc/nixos/ ~/nixconfig
        cd ~/nixconfig
        git add .
        git commit -m 'called updateNixosConfig script'
        git push origin awesome
      '';
  };
}
