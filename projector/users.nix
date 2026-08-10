{
    programs.zsh.enable = true;
    users.mutableUsers = false;
    users.users.projector = {
        isNormalUser = true;
        # hashedPassword = "$6$/0Gp.TYJT9C5bIPX$C/7zt9pyRke/eDsd8EGmHgvoaayngRj70uvR0B7QwBroYBDT8u6SETDVuNQ/99o61HRVR1ZlXcQnoaAb1hwWM0";
        hashedPassword = "!";
    };
    users.users.admin = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        hashedPassword = "$y$j9T$Cur1cOb.2uQWpyl4zQrYZ/$28ebqpkeYmFAI4eHXDIkmt/gNnvIzTyYIJUbdCqIYq6";
    };
    users.users.root.hashedPassword = "!";
}
