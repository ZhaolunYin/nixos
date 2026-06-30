{
    virtualisation.docker.enable = true;
    virtualisation.oci-containers.backend = "docker";
    hardware.nvidia-container-toolkit.enable = true; # enables --gpus=all support

    virtualisation.oci-containers.containers.wolf = {
        image = "ghcr.io/games-on-whales/wolf:stable";
        autoStart = true;
        environment = {
            NVIDIA_DRIVER_CAPABILITIES = "all";
            NVIDIA_VISIBLE_DEVICES = "all";
        };
        volumes = [
            "/etc/wolf/:/etc/wolf"
            "/var/run/docker.sock:/var/run/docker.sock:rw"
            "/dev/:/dev/:rw"
            "/run/udev:/run/udev:rw"
        ];
        extraOptions = [
            "--network=host"
            "--device=/dev/dri"
            "--device=/dev/uinput"
            "--device=/dev/uhid"
            "--device-cgroup-rule=c 13:* rmw"
            "--gpus=all"
        ];
    };
}
