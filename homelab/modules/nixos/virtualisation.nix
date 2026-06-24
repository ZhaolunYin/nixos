{ pkgs, ... }:
{
    programs.virt-manager.enable = true;
    virtualisation.libvirtd = {
        enable = true;
        qemu = {
            swtpm.enable = true;
            runAsRoot = true;
            package = pkgs.qemu_kvm;
        };
    };
}
