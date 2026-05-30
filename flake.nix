{
    description = "My Nixos config";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { nixpkgs, home-manager, ... }: {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./hosts/thinkpad
                ./modules/nixos
                home-manager.nixosModules.home-manager
                {
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        users.zhaolun = {
                            imports = [ 
                                ./modules/home
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
