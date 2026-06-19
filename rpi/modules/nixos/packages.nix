{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        bat
        duf
        dust
        eza
        fd
        procs
        python3
        ripgrep
        trash-cli
        uwsm
    ];
}

