{
    networking.networkmanager.wifi.powersave = false;

    powerManagement = {
        enable = true;
        cpuFreqGovernor = "performance";
        powertop.enable = false;
    };

    boot.kernelParams = [
        "processor.max_cstate=1" # Prevent deep CPU sleep states (lower latency)
        "intel_idle.max_cstate=0" # Intel: disable idle states (use amd_idle for AMD)
        "idle=poll" # Busy-poll instead of sleeping (lowest latency, more power)
        "mitigations=off" # Disable Spectre/Meltdown mitigations (perf boost, security tradeoff)
        "pcie_aspm=off" # Disable PCIe power saving (better NIC/GPU latency)
        "intel_pstate=active" # Use Intel's native pstate driver
    ];

    services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="cpu", ATTR{cpufreq/scaling_governor}="performance"
    '';

    services.tlp.enable = false;
    services.auto-cpufreq.enable = false;
}
