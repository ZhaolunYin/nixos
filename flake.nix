{
    description = "My Nixos config";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, ... }: {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./configuration.nix
                home-manager.nixosModules.default
                {
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        users.zhaolun = import ./home.nix;
                        backupFileExtension = "backup";
                    	extraSpecialArgs = { flakeRoot = self; };
                    };
                }
            ];
        };
    };
}
