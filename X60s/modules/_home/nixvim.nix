{
    # ---------------------------------------------------------------------------
    # Program configuration
    # ---------------------------------------------------------------------------
    programs.nixvim = {
        enable = true;
        defaultEditor = true;
        vimAlias = true;
        viAlias = true;

        # ---------------------------------------------------------------------------
        # Extra packages — LSP servers, formatters, and tools Neovim needs on PATH.
        # ---------------------------------------------------------------------------

        # ---------------------------------------------------------------------------
        # Plugins
        # ---------------------------------------------------------------------------
        plugins = {
            # Git signs in the gutter
            gitsigns.enable = true;

            # Markdown previewer
            markview = {
                enable = true;
            };

            # Pending keybind popup
            which-key = {
                enable = true;
                settings = {
                    delay = 0;
                    icons.mappings = true;
                };
            };

            # Completion
            nvim-cmp.enable = true;
            luasnip.enable = true;

            # Todo comments
            todo-comments.enable = true;

            # Mini collection
            mini = {
                enable = true;
                modules = {
                    ai = {};
                    surround = {};
                    hipatterns = {};
                    statusline = {};

                    icons = {
                        mock_nvim_web_devicons = true;
                    };
                };
            };

            # Treesitter — all grammars (default)
            treesitter = {
                enable = true;
                nixGrammars = true;
            };

            # Indent blankline
            indent-blankline.enable = true;

            # Autopairs
            nvim-autopairs.enable = true;
        };

        # Colorscheme
        colorschemes.gruvbox.enable = true;

        # ---------------------------------------------------------------------------
        # Options
        # ---------------------------------------------------------------------------
        extraConfigLua = ''
            # Number columns
            vim.opt.number = true
            # tab width 4
            vim.opt.tabstop = 4
            vim.opt.shiftwidth = 4
            vim.opt.expandtab = true
            # use unnamedplus for clipboard
            vim.opt.clipboard = "unnamedplus"
            # enable mouse support
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
            # hidden character chars
            vim.opt.listchars = {
                tab = "» "
                trail = "·"
                nbsp = "␣"
            }
        '';
    };
}
