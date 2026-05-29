{
    services.logind = {
        lidSwitch = "suspend-then-hibernate";
        lidSwitchExternalPower = "suspend-then-hibernate";
        lidSwitchDocked = "ignore";
    };
    systemd.sleep.settings.Sleep = {
        HibernateDelaySec = "30m";
    };
    services.tlp = {
        enable = true;
        settings = {
            TLP_PROFILE_BAT = "SAV";
            CPU_DRIVER_OPMODE_ON_AC = "active";
            CPU_DRIVER_OPMODE_ON_BAT = "active";
            CPU_DRIVER_OPMODE_ON_SAV = "active";
            CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
            CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
            CPU_ENERGY_PERF_POLICY_ON_SAV = "power";
            CPU_BOOST_ON_AC = 1;
            CPU_BOOST_ON_BAT = 0;
            CPU_BOOST_ON_SAV = 0;
            PLATFORM_PROFILE_ON_AC = "performance";
            PLATFORM_PROFILE_ON_BAT = "balanced";
            PLATFORM_PROFILE_ON_SAV = "low-power";
            AHCI_RUNTIME_PM_ON_AC = "on";
            AHCI_RUNTIME_PM_ON_BAT = "auto";
            AMDGPU_ABM_LEVEL_ON_AC = 0;
            AMDGPU_ABM_LEVEL_ON_BAT = 1;
            AMDGPU_ABM_LEVEL_ON_SAV = 3;
            START_CHARGE_THRESH_BAT0 = 85;
            STOP_CHARGE_THRESH_BAT0 = 90;
        };
    };
}
