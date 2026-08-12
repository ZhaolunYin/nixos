{ pkgs, ... }:
{
    programs.neovim = {
        enable = true;
        defaultEditor = true;
        vimAlias = true;
        viAlias = true;

        plugins = with pkgs.vimPlugins; [
            gitsigns-nvim
            which-key-nvim
            todo-comments-nvim
            mini-nvim
            indent-blankline-nvim
            nvim-autopairs
        ];
        extraLuaConfig = ''
            vim.opt.number = true
            vim.opt.tabstop = 4
            vim.opt.shiftwidth = 4
            vim.opt.expandtab = true
            vim.opt.clipboard = "unnamedplus"
            vim.opt.mouse = "a"
            vim.opt.showmode = false
            vim.opt.breakindent = true
            vim.opt.undofile = true
            vim.opt.ignorecase = true
            vim.opt.smartcase = true
            vim.opt.signcolumn = "yes"
            vim.opt.updatetime = 250
            vim.opt.timeoutlen = 300
            vim.opt.splitright = true
            vim.opt.splitbelow = true
            vim.opt.list = true
            vim.opt.inccommand = "split"
            vim.opt.cursorline = true
            vim.opt.scrolloff = 10
            vim.opt.confirm = true

            vim.opt.listchars = {
                tab = "» ",
                trail = "·",
                nbsp = "␣",
            }

            -- Plugins
            require("gitsigns").setup()
            require("which-key").setup()
            require("todo-comments").setup()
            require("mini.ai").setup()
            require("mini.comment").setup()
            require("ibl").setup()
            require("nvim-autopairs").setup()
        '';
    };
}
