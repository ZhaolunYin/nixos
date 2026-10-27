{
    # Lid / suspend behaviour.
    # Note: noctalia locks on PrepareForSleep (lock_before_suspend), and hypridle
    # issues `loginctl lock-session` on its idle timeout, so suspend stays locked.
    services.logind.settings.Login = {
        HandleLidSwitch = "suspend";
        HandleLidSwitchExternalPower = "ignore";
        HandleLidSwitchDocked = "ignore";
    };
    powerManagement.enable = true;

    services.tlp = {
        enable = true;

        # Only keys that TLP 1.10 actually knows about go here: unknown keys are
        # dropped silently. Check with `tlp-stat -c` after a rebuild.
        settings = {
            # TLP profile in use per power source. On battery the *_SAV variants
            # of the split parameters below are applied, i.e. the battery profile
            # is intentionally aggressive. Delete TLP_PROFILE_BAT if you would
            # rather have the *_BAT values apply on battery and reach the
            # power-saver settings only via `tlp power-saver`.
            TLP_PROFILE_BAT = "SAV";

            # amd-pstate-epp is the active cpufreq driver (scaling_driver =
            # amd-pstate-epp), so the scaling governor is pinned to `powersave`
            # by the kernel and *energy/performance policy* is what actually
            # tunes the CPU here. The previous CPU_FREQ_GOVERNATOR_* keys never
            # existed in TLP, so they were no-ops.
            CPU_DRIVER_OPMODE_ON_AC = "active";
            CPU_DRIVER_OPMODE_ON_BAT = "active";
            CPU_DRIVER_OPMODE_ON_SAV = "active";
            CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
            CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
            CPU_ENERGY_PERF_POLICY_ON_SAV = "power";

            # Keep battery quiet/cold; the platform profile already raises clocks
            # when there is work to do.
            CPU_BOOST_ON_AC = 1;
            CPU_BOOST_ON_BAT = 0;
            CPU_BOOST_ON_SAV = 0;

            PLATFORM_PROFILE_ON_AC = "performance";
            PLATFORM_PROFILE_ON_BAT = "balanced";
            PLATFORM_PROFILE_ON_SAV = "low-power";

            AHCI_RUNTIME_PM_ON_AC = "on";
            AHCI_RUNTIME_PM_ON_BAT = "auto";

            # Panel backlight modulation (contrast/battery saving). Start at 0
            # while plugged in; higher levels trade contrast for runtime.
            AMDGPU_ABM_LEVEL_ON_AC = 0;
            AMDGPU_ABM_LEVEL_ON_BAT = 1;
            AMDGPU_ABM_LEVEL_ON_SAV = 3;

            # Battery conservation: verified live via
            # /sys/class/power_supply/BAT0/charge_{start,stop}_threshold
            START_CHARGE_THRESH_BAT0 = 85;
            STOP_CHARGE_THRESH_BAT0 = 90;
        };
    };
}
