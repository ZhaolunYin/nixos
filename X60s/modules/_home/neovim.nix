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
            nvim-treesitter
            indent-blankline-nvim
            nvim-autopairs
            vim-surround
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
        '';
    };
}
