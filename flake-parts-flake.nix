{
  description = "My NixOS config using flake-parts";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";

    nixpkgs.url = "nixpkgs/nixos-unstable";

    # System-level modules
    disko.url = "github:nix-community/disko";
    impermanence.url = "github:nix-community/impermanence";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    plasma-manager.url = "github:nix-community/plasma-manager";

    # Home-manager & related
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    noctalia.url = "github:noctalia-dev/noctalia-shell";

    import-tree.url = "github:denful/import-tree";
  };

  outputs =
    inputs@{ flake-parts, nixpkgs, ... }:
    let
      # ────────────────────────────────────────────────────────────────
      # 1. Systems — which architectures you build for
      # ────────────────────────────────────────────────────────────────
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      lib = nixpkgs.lib;

      # ────────────────────────────────────────────────────────────────
      # 2. perSystem — system-specific packages, devShells, checks
      #    Runs once per system listed in `systems`.
      # ────────────────────────────────────────────────────────────────
      perSystem =
        {
          self',
          nixpkgs',
          config',
          lib',
          system,
          ...
        }: {
          # Add packages, devShells, checks here:
          #
          # packages.my-tool = nixpkgs'.pkgs.callPackage ./my-tool { };
          # devShells.default = nixpkgs'.pkgs.mkShell { };
        };

      # ────────────────────────────────────────────────────────────────
      # 3. Common base modules shared by ALL machines
      #    This eliminates the repeated module list on every machine.
      # ────────────────────────────────────────────────────────────────
      commonModules = [
        inputs.disko.nixosModules.disko
        inputs.impermanence.nixosModules.impermanence
        inputs.nix-flatpak.nixosModules.nix-flatpak
        inputs.home-manager.nixosModules.home-manager
      ];

      # ────────────────────────────────────────────────────────────────
      # 4. Shared home-manager config (DRY)
      #    Collapses the ~30 lines of repeated home-manager boilerplate
      #    per machine into a single reusable call.
      # ────────────────────────────────────────────────────────────────
      mkHomeManager =
        {
          user,
          extraHomeImports ? [ ],
        }:
        {
          lib',
          nixvim,
          noctalia,
          plasma-manager,
          import-tree,
          ...
        }: {
          home-manager.users.${user} = {
            home.stateVersion = "26.05";
            backupFileExtension = "hm-backup";
            useGlobalPkgs = true;
            useUserPackages = true;

            imports =
              [
                nixvim.homeModules.nixvim
                (import-tree ./share/modules/_home)
              ]
              ++ extraHomeImports;
          };
        };

      # ────────────────────────────────────────────────────────────────
      # 5. Machine definitions
      #    Each machine is now ~8 lines instead of ~25.
      #    The common modules and home-manager boilerplate are factored
      #    out. Adding a new machine is trivial.
      # ────────────────────────────────────────────────────────────────
      thinkpad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit (inputs) import-tree;
        };
        modules = [
          (import-tree ./thinkpad)
          (import-tree ./share)
        ] ++ commonModules
        ++ [
          (mkHomeManager {
            user = "zhaolun";
            extraHomeImports = [
              noctalia.homeModules.default
              (import-tree ./thinkpad/modules/_home)
            ];
          })
        ];
      };

      rpi = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = {
          inherit (inputs) import-tree;
        };
        modules = [
          (import-tree ./rpi)
          (import-tree ./share)
        ] ++ commonModules
        ++ [
          (mkHomeManager {
            user = "admin";
          })
        ];
      };

      homelab = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit (inputs) import-tree;
        };
        modules = [
          (import-tree ./homelab)
          (import-tree ./share)
        ] ++ commonModules
        ++ [
          (mkHomeManager {
            user = "lab";
          })
        ];
      };

      projector = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit (inputs) import-tree;
        };
        modules = [
          (import-tree ./projector)
          (import-tree ./share)
        ] ++ commonModules
        ++ [
          plasma-manager.homeModules.plasma-manager
          (mkHomeManager {
            user = "projector";
            extraHomeImports = [
              (import-tree ./projector/modules/_home)
            ];
          })
        ];
      };

    in
    {
      # ────────────────────────────────────────────────────────────────
      # 6. THE flake-parts output
      # ────────────────────────────────────────────────────────────────
      flake-parts = {
        # ── perSystem: one invocation per system ──
        #    Use this for packages, devShells, checks, etc.
        perSystem = lib.genAttrs systems perSystem;

        # ── nixosConfigurations: your machines ──
        #    These are the names you pass to `nixos-rebuild switch --flake .#<name>`
        nixosConfigurations = {
          inherit thinkpad rpi homelab projector;
        };
      };
    };
}
