{ pkgs, ... }:
{
    home.packages = with pkgs; [
        pinentry
    ];

    home.file.".gnupg/gpg-agent.conf".text = ''
    pinentry-program ${pkgs.pinentry}/bin/pinentry
    '';

    home.file.".gnupg/gpg.conf".text = ''
    use-agent
    '';
}
