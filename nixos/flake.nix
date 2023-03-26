{
  description = "Adrianaris Desktop Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    emacs-overlay.url = "github:nix-community/emacs-overlay";

    # awesome modules
    bling = { url = "github:BlingCorp/bling"; flake = false; };
    rubato = { url = "github:andOrlando/rubato"; flake = false; };
  };

  outputs = { self, nixpkgs, home-manager, nixpkgs-f2k, emacs-overlay, ... }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };

      lib = nixpkgs.lib.extend
        (final: prev: 
          let
            inherit (lib) mkOption types;
          in
          {
            mkOpt = type: default:
              mkOption { inherit type default; };

            mkOpt' = type: default: description:
              mkOption { inherit type default description; };

            mkBoolOpt = default: mkOption {
              inherit default;
              type = types.bool;
              example = true;
            };
          });

      extraSpecialArgs = {
        inherit inputs self;
        bling = inputs.bling;
        rubato = inputs.rubato;
      };

      overlays = [
        nixpkgs-f2k.overlays.default
        emacs-overlay.overlay
      ];
    in
    {
      homeConfigurations = {
        "adrianaris@nixos" = home-manager.lib.homeManagerConfiguration {
          inherit extraSpecialArgs pkgs;
          modules = [
            ./hosts/nixos/user.nix
            {
              home = {
                username = "adrianaris";
                homeDirectory = "/home/adrianaris";
                stateVersion = "23.05";
              };
              nixpkgs.overlays = overlays;
              programs.home-manager.enable = true;
            }
          ];
        };
      };
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            {
              nixpkgs.overlays = [
                nixpkgs-f2k.overlays.default
              ];
            }
            ./hosts/nixos/configuration.nix
          ];
        };
      };
    };
}
