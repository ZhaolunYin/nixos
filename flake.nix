{
    description = "My Nixos config";

    inputs = {
        disko.url = "github:nix-community/disko";
        home-manager.url = "github:nix-community/home-manager";
        home-manager-23_11 = {
            url = "github:nix-community/home-manager/release-23.11";
            inputs.nixpkgs.follows = "nixpkgs-23_11";
        };
        impermanence.url = "github:nix-community/impermanence";
        import-tree.url = "github:denful/import-tree";
        nixpkgs.url = "nixpkgs/nixos-unstable";
        nixpkgs-23_11.url = "nixpkgs/nixos-23.11";
        nixvim.url = "github:nix-community/nixvim";
        nix-flatpak.url = "github:gmodena/nix-flatpak";
        noctalia.url = "github:noctalia-dev/noctalia-shell";
        plasma-manager.url = "github:nix-community/plasma-manager";
    };

    outputs = inputs@{
    disko,
    home-manager,
    home-manager-23_11,
    impermanence,
    import-tree,
    nixpkgs,
    nixpkgs-23_11,
    nixvim,
    nix-flatpak,
    noctalia,
    plasma-manager,
    ...
    }:
        {
            nixosConfigurations.thinkpad = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    (import-tree ./thinkpad)
                    (import-tree ./share)
                    disko.nixosModules.disko
                    impermanence.nixosModules.impermanence
                    nix-flatpak.nixosModules.nix-flatpak
                    home-manager.nixosModules.home-manager
                    {
                        home-manager = {
                            useGlobalPkgs = true;
                            useUserPackages = true;
                            users.zhaolun = {
                                imports = [
                                    noctalia.homeModules.default
                                    nixvim.homeModules.nixvim
                                    (import-tree ./thinkpad/modules/_home)
                                    (import-tree ./share/_home)
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
                    (import-tree ./rpi)
                    (import-tree ./share)
                    home-manager.nixosModules.home-manager
                    {
                        home-manager = {
                            useGlobalPkgs = true;
                            useUserPackages = true;
                            users.admin = {
                                imports = [
                                    nixvim.homeModules.nixvim
                                    (import-tree ./share/_home)
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
                    (import-tree ./homelab)
                    (import-tree ./share)
                    disko.nixosModules.disko
                    home-manager.nixosModules.home-manager
                    {
                        home-manager = {
                            useGlobalPkgs = true;
                            useUserPackages = true;
                            users.lab = {
                                imports = [
                                    nixvim.homeModules.nixvim
                                    (import-tree ./share/_home)
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
                    (import-tree ./projector)
                    (import-tree ./share)
                    disko.nixosModules.disko
                    home-manager.nixosModules.home-manager
                    {
                        home-manager = {
                            useGlobalPkgs = true;
                            useUserPackages = true;
                            users.projector = {
                                imports = [
                                    plasma-manager.homeModules.plasma-manager
                                    nixvim.homeModules.nixvim
                                    (import-tree ./projector/modules/_home)
                                    (import-tree ./share/_home)
                                ];
                                home.stateVersion = "26.05";
                            };
                            backupFileExtension = "hm-backup";
                        };
                    }
                ];
            };
            nixosConfigurations.X60s = nixpkgs-23_11.lib.nixosSystem {
                system = "i686-linux";
                extraSpecialArgs = {
                    inherit inputs;
                };
                modules = [
                    (import-tree ./X60s)
                        home-manager-23_11.nixosModules.home-manager
                        {
                            home-manager = {
                                useGlobalPkgs = true;
                                useUserPackages = true;
                                extraSpecialArgs = {
                                    inherit inputs;
                                };
                                users.zhaolun = {
                                    imports = [
                                        (import-tree ./X60s/modules/_home)
                                    ];
                                };
                            };
                        }
                ];
            };
        };
}
