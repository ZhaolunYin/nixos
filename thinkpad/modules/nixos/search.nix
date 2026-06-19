{
	services.searx = {
		enable = true;
		redisCreateLocally = true;

		settings = {
			server = {
				bind_address = "127.0.0.1";
				port = 8888;
				secret_key = "zhaolun_thinkpad_sear_search";
				limiter = false;
			};
			search = {
				formats = [ "html" "json" ];
			};

		};
	};
}
