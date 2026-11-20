{
    hardware.raspberry-pi."4".dwc2 = {
        enable = true;
        dr_mode = "peripheral";
    };
    boot.kernelModules = [ "g_ether" ];
}
