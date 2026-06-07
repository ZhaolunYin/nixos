{
    description = "My Nixos config";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        noctalia = {
            url = "github:noctalia-dev/noctalia-shell/v5";
        };
    };

    outputs = { nixpkgs, home-manager, noctalia, ... }: {
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
                                noctalia.homeModules.default
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
