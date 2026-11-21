{ pkgs, lib, ... }:

let
    configTxt = pkgs.writeText "config.txt" ''
        [pi4]
        kernel=u-boot-rpi4.bin
        enable_gic=1
        armstub=armstub8-gic.bin
        disable_overscan=1
        arm_boost=1

        [all]
        arm_64bit=1
        avoid_warnings=1
        enable_uart=1
    '';
in
{
    boot.initrd.kernelModules = [ "dwc2" "g_ether" ];
    hardware.deviceTree = {
        enable = true;
        filter = "bcm2711-rpi-*.dtb";
        overlays = [{
            name = "dwc2-peripheral";
            dtsText = ''
                /dts-v1/;
                /plugin/;
                / {
                    compatible = "brcm,bcm2711";
                    fragment@0 {
                        target-path = "/soc/usb@7e980000";
                        __overlay__ {
                            compatible = "brcm,bcm2835-usb";
                            dr_mode = "peripheral";
                            g-np-tx-fifo-size = <32>;
                            g-rx-fifo-size = <558>;
                            g-tx-fifo-size = <512 512 512 512 512 256 256>;
                            status = "okay";
                        };
                    };
                };
            '';
        }];
    };
    system.activationScripts.raspberryPiFirmware = lib.stringAfter [ "specialfs" ] ''
        mkdir -p /boot/firmware
        if ! mountpoint -q /boot/firmware && [ -e /dev/disk/by-label/FIRMWARE ]; then
            mount /dev/disk/by-label/FIRMWARE /boot/firmware || true
        fi
        if mountpoint -q /boot/firmware; then
            install -m 0644 ${configTxt} /boot/firmware/config.txt
        fi
    '';
}
