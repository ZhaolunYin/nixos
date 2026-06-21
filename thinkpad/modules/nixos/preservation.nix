{ preservation, ... }:
{
    boot.tmp.cleanOnBoot = true;

    preservation = {
        enable = true;

        preserveAt."/persistent" = {
            files = [
                { file = "/etc/machine-id"; inInitrd = true; }
            ];

            directories = [
                "/etc/NetworkManager/system-connections"
                "/etc/nixos"
                "/tmp"
                "/var/lib/bluetooth/"
                "/var/lib/fprint"
                "/var/lib/nixos"
                "/var/log"
            ];

            users.zhaolun = {
                files = [];
                directories = [
                    ".config/mozilla"
                    ".gnupg"
                    ".password-store"
                ];
            };
        };
    };
}
