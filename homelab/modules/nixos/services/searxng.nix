{
    services.searx = {
        enable = true;
        redisCreateLocally = true;

        settings = {
            server = {
                bind_address = "0.0.0.0";
                port = 2002;
                secret_key = "98udasdf2lqajshdas6d129931b10";
                limiter = false;
            };
            search = {
                formats = [ "html" "json" ];
            };

        };
    };
}
