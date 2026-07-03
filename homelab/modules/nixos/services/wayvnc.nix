{
    services.wayvnc = {
        enable = true;
        settings.default = {
            address = "0.0.0.0";
            enable_auth = false; # set up a cert/password if exposing beyond localhost
        };
    };
}
