{ pkgs, ... }:
{
    home.packages = with pkgs; [
        pinentry-curses
	gnupg
    ];

    home.file.".gnupg/gpg-agent.conf".text = ''
    pinentry-program ${pkgs.pinentry-curses}/bin/pinentry
    '';

    home.file.".gnupg/gpg.conf".text = ''
    use-agent
    '';
}
