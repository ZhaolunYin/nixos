{ lib, ... }:

{
    disko.devices = {
        disk.main = {
            type = "disk";
            device = lib.mkDefault "/dev/sda";

            content = {
                type = "table";
                format = "msdos";

                partitions = [
                    {
                        name = "root";
                        start = "1MiB";
                        end = "-2GiB";

                        content = {
                            type = "filesystem";
                            format = "ext4";
                            mountpoint = "/";
                        };
                    }
                    {
                        name = "swap";
                        start = "-2GiB";
                        end = "100%";

                        content = {
                            type = "swap";
                        };
                    }
                ];
            };
        };
    };
}
