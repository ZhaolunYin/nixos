{
    services.searx = {
        enable = true;
        redisCreateLocally = true;

        settings = {
            server = {
                bind_address = "127.0.0.1";
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
