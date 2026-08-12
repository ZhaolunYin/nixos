{
    boot.binfmt.emulatedSystems = [
        "i686-linux"
    ];
    nix.settings = {
        trusted-users = [ "root" "lab" ];
        extra-platforms = [ "i686-linux" ];
        system-features = [ "kvm" "nixos-test" "big-parallel" ];
    };
}
