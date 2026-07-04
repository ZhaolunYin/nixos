{
    disko.devices = {
        disk = {
            system = {
                type = "disk";
                device = "/dev/disk/by-id/ata-ST9500420ASG_5VJDAS2S";

                content = {
                    type = "gpt";
                    partitions = {
                        ESP = {
                            size = "1G";
                            type = "EF00";
                            content = {
                                type = "filesystem";
                                format = "vfat";
                                mountpoint = "/boot";
                                mountOptions = [ "umask=0077" ];
                            };
                        };

                        root = {
                            size = "100%";
                            content = {
                                type = "filesystem";
                                format = "ext4";
                                mountpoint = "/";
                            };
                        };
                    };
                };
            };

            home = {
                type = "disk";
                device = "/dev/disk/by-id/ata-ST9500420ASG_5VJDC3W9";

                content = {
                    type = "gpt";
                    partitions = {
                        home = {
                            size = "100%";
                            content = {
                                type = "filesystem";
                                format = "ext4";
                                mountpoint = "/home";
                            };
                        };
                    };
                };
            };
        };
    };
}
