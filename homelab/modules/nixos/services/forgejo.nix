{ lib, pkgs, config, ... }:
{
    services.forgejo = {
        enable = true;
        lfs.enable = true;

        settings = {
            server = {
                HTTP_PORT = 2003;
            };
        };
        secrets = {
            mailer.PASSWD = config.age.secrets.forgejo-mailer-password.path;
        };
    };
}
