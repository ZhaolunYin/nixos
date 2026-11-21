{ pkgs, lib, ... }:
let
    configTxt = pkgs.writeText "config.txt" ''
        [pi4]
        kernel=u-boot-rpi4.bin
        enable_gic=1
        armstub=armstub8-gic.bin
        disable_overscan=1
        arm_boost=1
        dtoverlay=dwc2,dr_mode=peripheral

        [all]
        arm_64bit=1
        avoid_warnings=1
        enable_uart=1
    '';
in
{
    boot.initrd.kernelModules = [ "dwc2" "g_ether" ];

    system.activationScripts.raspberryPiFirmware = lib.stringAfter [ "specialfs" ] ''
        if mountpoint -q /boot/firmware; then
            mkdir -p /boot/firmware/overlays
            install -m 0644 ${configTxt} /boot/firmware/config.txt
            install -m 0644 ${pkgs.raspberrypifw}/share/raspberrypi/boot/overlays/dwc2.dtbo /boot/firmware/overlays/dwc2.dtbo
        fi
    '';
}
