{ lib, ... }:
{
    fileSystems."/persist".neededForBoot = true;

    boot.initrd.systemd.services.rollback = {
        description = "Rollback root ZFS";
        wantedBy = [ "initrd.target" ];
        after = [ "zfs-import-zroot.service" ];
        before = [ "sysroot.mount" ];
        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";
        script = "zfs rollback -r zroot/local/root@blank";
    };

    environment.persistence."/persist" = {
        enable = true;
        hideMounts = true;
        directories = [
            "/etc/NetworkManager/system-connections"
            "/var/log"
            "/var/lib/bluetooth"
            "/var/lib/flatpak"
            "/var/lib/fprint"
            "/var/lib/nixos"
            "/var/lib/tailscale"
            "/var/lib/systemd/coredump"
            {
                directory = "/var/lib/colord"; 
                user = "colord"; 
                group = "colord"; 
                mode = "u=rwx,g=rx,o="; 
            }
        ];
        files = [
            "/etc/machine-id"
        ];
    };
}
