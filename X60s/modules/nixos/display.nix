{ pkgs, ... }:
{
    services.xserver = {
        enable = true;
        windowManager.dwm = {
            enable = true;
            package = pkgs.dwm.override {
                conf = ./patches/dwm.h;
                patches = with pkgs; [
                    (fetchpatch {
                        url = "https://dwm.suckless.org/patches/attachaside/dwm-attachaside-6.4.diff";
                        hash = "sha256-KUIO0oVxQs+RqRAXaEcHJWtG2b0OtWrgMWn0+m+1r78=";
                    })
                    (fetchpatch {
                        url = "https://dwm.suckless.org/patches/vanitygaps/dwm-cfacts-vanitygaps-6.4_combo.diff";
                        hash = "sha256-i/lvTKDXdUrtxpx0epBUz+FSSlO2M+CJu/8SFr2wbG0=";
                    })
                    (fetchpatch {
                        url = "https://dwm.suckless.org/patches/alpha/dwm-alpha-6.4.diff";
                        hash = "sha256-vHfjGJ5fXpdB8ZQV7jSNg6B5ommiq+t3rjnoq3kqfoE=";
                    })
                ];
            };
        };
        displayManager.startx.enable = true;
        videoDrivers = [ "intel" ];
    };
    environment.systemPackages = with pkgs; [
        xorg.xf86videointel
    ];
}
