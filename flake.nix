{
  description = "My Nixos config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      noctalia,
      nixvim,
      ...
    }:
    {
      nixosConfigurations.thinkpad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./thinkpad
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.zhaolun = {
                imports = [
                  noctalia.homeModules.default
                  nixvim.homeModules.nixvim
                  ./thinkpad/modules/home
                  ./share/home
                ];
                home.stateVersion = "26.05";
              };
              backupFileExtension = "bak";
            };
          }
        ];
      };
    };
}
