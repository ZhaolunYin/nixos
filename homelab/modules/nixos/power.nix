{
    networking.networkmanager.wifi.powersave = false;

    powerManagement = {
        enable = true;
        cpuFreqGovernor = "performance";
        powertop.enable = false;
    };

    services.tlp.enable = false;
    services.auto-cpufreq.enable = false;
}
