{ pkgs, ... }:
{
    services = {
        desktopManager.plasma6.enable = true;
        displayManager.sddm.enable = true;
        displayManager.sddm.wayland.enable = true;
    };

    environment.systemPackages = with pkgs; [
        kdePackages.kcalc # Calculator
        kdePackages.kclock # Clock app
        kdePackages.kolourpaint # Simple paint program
        kdePackages.ksystemlog # System log viewer
        kdePackages.sddm-kcm # SDDM configuration module

        hardinfo2 # System benchmarks and hardware info
        wayland-utils # Wayland diagnostic tools
        wl-clipboard # Wayland copy/paste support
        vlc # Media player
    ];
}
