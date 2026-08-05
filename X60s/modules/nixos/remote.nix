{
    nix = {
        distributedBuilds = true;

        buildMachines = [
            {
                hostName = "homelab";
                sshUser = "lab";
                protocol = "ssh";

                system = "i686-linux";

                maxJobs = 16;
                speedFactor = 20;

                supportedFeatures = [ "big-parallel" ];
            }
        ];

        settings.builders-use-substitutes = true;
    };
}
