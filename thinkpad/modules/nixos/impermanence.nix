{ impermanence, lib, ... }:
{
    boot.initrd.postDeviceCommands = lib.mkAfter ''
    zfs rollback -r zroot/local/root@blank
    '';

    environment.persistence."/persist" = {
        enable = true;  # NB: Defaults to true, not needed
        hideMounts = true;
        directories = [
            "/etc/NetworkManager/system-connections"
            "/var/log"
            "/var/lib/bluetooth"
            "/var/lib/nixos"
            "/var/lib/systemd/coredump"
            "/etc/NetworkManager/system-connections"
            {
                directory = "/var/lib/colord"; 
                user = "colord"; 
                group = "colord"; 
                mode = "u=rwx,g=rx,o="; 
            }
        ];
        files = [
            "/etc/machine-id"
            { file = "/var/keys/secret_file"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
        ];
    };
}
