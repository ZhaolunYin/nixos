{
    boot.kernelModules = [ "g_ether" ];

    hardware.deviceTree = {
        enable = true;
        overlays = [{
            name = "dwc2-peripheral";
            dtsText = ''
                /dts-v1/;
                /plugin/;
                / {
                    compatible = "brcm,bcm2711";
                    fragment@0 {
                        target = <&usb>;
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
}
