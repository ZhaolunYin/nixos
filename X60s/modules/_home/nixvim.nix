{ pkgs, ... }:
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
        extraPackages = with pkgs; [
            # LSP servers
            lua-language-server
            clang-tools
            rust-analyzer
            nixd
            pyright
        ];

        # ---------------------------------------------------------------------------
        # Plugins
        # ---------------------------------------------------------------------------
        plugins = {
            # Git signs in the gutter
            gitsigns = {
                enable = true;
                settings.signs = {
                    add.text = "+";
                    change.text = "~";
                    delete.text = "_";
                    topdelete.text = "‾";
                    changedelete.text = "~";
                };
            };

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

            # LSP
            fidget.enable = true;

            lsp = {
                enable = true;

                servers = {
                    lua_ls = {
                        enable = true;
                    };

                    clangd = {
                        enable = true;
                        cmd = [
                            "clangd"
                            "--background-index"
                            "--clang-tidy"
                        ];
                    };

                    rust_analyzer = {
                        enable = true;

                        /*
                        Do not auto install cargo and rustc
                        because if they are not installed
                        I will not be writing rust code
                        */
                        installCargo = false;
                        installRustc = false;

                        settings = {
                            rust-analyzer = {
                                cargo.allFeatures = true;
                            };
                        };
                    };

                    nixd.enable = true;
                    pyright.enable = true;
                };
            };

            # Completion
            blink-cmp = {
                enable = true;
                settings = {
                    keymap.preset = "default";
                    appearance.nerd_font_variant = "mono";
                    completion = {
                        documentation.auto_show = true;
                        documentation.auto_show_delay_ms = 200;
                    };
                    sources.default = [
                        "lsp"
                        "path"
                        "snippets"
                    ];
                    fuzzy.implementation = "lua";
                    signature.enabled = true;
                    completion.trigger.show_on_keyword = true;
                    completion.trigger.show_on_trigger_character = true;
                };
            };

            luasnip.enable = true;

            # Todo comments
            todo-comments = {
                enable = true;
                settings.signs = false;
            };

            # Mini collection
            mini-ai.enable = true;
            mini-surround.enable = true;
            mini-hipatterns.enable = true;
            mini-statusline.enable = true;
            mini-icons = {
                enable = true;
                mockDevIcons = true;
            };

            # Treesitter — all grammars (default)
            treesitter = {
                enable = true;
                nixGrammars = true;
            };

            # Indent blankline
            indent-blankline = {
                enable = true;
            };

            # Autopairs
            nvim-autopairs = {
                enable = true;
            };
        };

        # Colorscheme
        colorschemes.gruvbox.enable = true;

        # ---------------------------------------------------------------------------
        # Options
        # ---------------------------------------------------------------------------
        opts = {
            # Number columns
            number = true;
            # tab width 4
            tabstop = 4;
            shiftwidth = 4;
            expandtab = true;
            # use unnamedplus for clipboard
            clipboard = "unnamedplus";
            # enable mouse support
            mouse = "a";
            showmode = false;
            breakindent = true;
            undofile = true;
            ignorecase = true;
            smartcase = true;
            signcolumn = "yes";
            updatetime = 250;
            timeoutlen = 300;
            splitright = true;
            splitbelow = true;
            list = true;
            inccommand = "split";
            cursorline = true;
            scrolloff = 10;
            confirm = true;
            # hidden character chars
            listchars = {
                tab = "» ";
                trail = "·";
                nbsp = "␣";
            };
        };

        # ---------------------------------------------------------------------------
        # Diagnostics
        # ---------------------------------------------------------------------------
        diagnostic = {
            settings = {
                update_in_insert = false;
                severity_sort = true;
                float.border = "rounded";
                float.source = "if_many";
                underline.severity.min = "WARN";
                virtual_text = true;
                virtual_lines = false;
                jump.float = true;
            };
        };
    };
}
