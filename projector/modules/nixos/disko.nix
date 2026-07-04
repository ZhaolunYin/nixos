{
    disko.devices = {
        disk = {
            system = {
                type = "disk";
                device = "/dev/sda";

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
                        swap = {
                            size = "64G";
                            content = {
                                type = "swap";
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
                device = "/dev/sdb";

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
