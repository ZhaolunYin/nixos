{
    programs.virt-manager.enable = true;
    virtualisation.libvirtd = {
        enable = true;
        qemu = {
            swtpm.enable = true;
            ovmf.enable = true;
            runAsRoot = true;
            package = pkgs.qemu_kvm;
        };
    };
}
