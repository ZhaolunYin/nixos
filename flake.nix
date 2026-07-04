{
    description = "My Nixos config";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        impermanence.url = "github:nix-community/impermanence";

        disko = {
            url = "github:nix-community/disko";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        noctalia = {
            url = "github:noctalia-dev/noctalia-shell";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nixvim = {
            url = "github:nix-community/nixvim";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { nixpkgs, disko, home-manager, impermanence, noctalia, nixvim, ... }:
        {
            nixosConfigurations.thinkpad = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./thinkpad
                    disko.nixosModules.disko
                    impermanence.nixosModules.impermanence
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
                            backupFileExtension = "hm-backup";
                        };
                    }
                ];
            };

            nixosConfigurations.rpi = nixpkgs.lib.nixosSystem {
                system = "aarch64-linux";
                modules = [
                    ./rpi
                    home-manager.nixosModules.home-manager
                    {
                        home-manager = {
                            useGlobalPkgs = true;
                            useUserPackages = true;
                            users.admin = {
                                imports = [
                                    nixvim.homeModules.nixvim
                                    ./share/home
                                ];
                                home.stateVersion = "26.05";
                            };
                            backupFileExtension = "hm-backup";
                        };
                    }
                ];
            };

            nixosConfigurations.homelab = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./homelab
                    disko.nixosModules.disko
                    home-manager.nixosModules.home-manager
                    {
                        home-manager = {
                            useGlobalPkgs = true;
                            useUserPackages = true;
                            users.lab = {
                                imports = [
                                    nixvim.homeModules.nixvim
                                    ./share/home
                                ];
                                home.stateVersion = "26.05";
                            };
                            backupFileExtension = "hm-backup";
                        };
                    }
                ];
            };

            nixosConfigurations.projector = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./projector
                    disko.nixosModules.disko
                    home-manager.nixosModules.home-manager
                    {
                        home-manager = {
                            useGlobalPkgs = true;
                            useUserPackages = true;
                            users.projector = {
                                imports = [
                                    nixvim.homeModules.nixvim
                                    ./share/home
                                    ./projector/modules/home
                                ];
                                home.stateVersion = "26.05";
                            };
                            backupFileExtension = "hm-backup";
                        };
                    }
                ];
            };
        };
}
