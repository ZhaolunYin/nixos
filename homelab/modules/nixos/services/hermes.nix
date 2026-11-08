# vim: set tabstop=2 shiftwidth=2 expandtab :
{ config, lib, hermes-agent, ... }:
{
  imports = [ hermes-agent.nixosModules.default ];

  services.hermes-agent = {
    enable = true;
    addToSystemPackages = true;   # hermes CLI shares state with the service

    # TELEGRAM_BOT_TOKEN, TELEGRAM_ALLOWED_USERS, WhatsApp vars live here
    environmentFiles = [ "/etc/hermes/env" ];

    # non-secret; the store is world-readable but "none" isn't a secret
    environment.OPENAI_API_KEY = "none";

    settings.model = {
      provider = "custom";
      base_url = "http://127.0.0.1:2001/v1";
      default = "gemma-4-26B-A4B-uncensored";
      context_length = 65536;
    };
  };

  # keep the llama-server ordering from your OpenClaw module
  systemd.services.hermes-agent = {
    after = lib.optionals config.services.llama-cpp.enable [ "llama-cpp.service" ];
    wants = lib.optionals config.services.llama-cpp.enable [ "llama-cpp.service" ];
  };
}
