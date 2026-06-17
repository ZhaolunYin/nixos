{ pkgs, ... }:

{
    programs.neovim = {
        enable = true;
        defaultEditor = true;
        vimAlias = true;
        viAlias = true;

        # ---------------------------------------------------------------------------
        # Extra packages — LSP servers, formatters, and tools Neovim needs on PATH.
        # Mason is removed; these replace everything it would have installed.
        # ---------------------------------------------------------------------------
        extraPackages = with pkgs; [
            # LSP servers
            lua-language-server   # lua_ls
            stylua                # Lua formatter (used by conform.nvim)

            # Add more as needed, e.g.:
            # rust-analyzer
            # pyright
            # nodePackages.typescript-language-server
            # nil  (Nix LSP)

            # Telescope runtime deps
            ripgrep
            fd

            # Treesitter needs a C compiler to build parsers
            gcc
        ];

        # ---------------------------------------------------------------------------
        # Plugins — Nix manages all of them; lazy.nvim is removed entirely.
        # ---------------------------------------------------------------------------
        plugins = with pkgs.vimPlugins; [
            # Git signs in the gutter
            gitsigns-nvim

            # Markdown previewer
            markview-nvim

            # Pending keybind popup
            which-key-nvim

            # Fuzzy finder
            telescope-nvim
            telescope-fzf-native-nvim
            telescope-ui-select-nvim
            plenary-nvim
            nvim-web-devicons

            # LSP
            nvim-lspconfig
            fidget-nvim

            # Formatter
            conform-nvim

            # Completion
            blink-cmp
            luasnip

            # Colorscheme
            catppuccin-nvim

            # Todo comments
            todo-comments-nvim

            # Mini collection (ai, surround, hipatterns, statusline)
            mini-nvim

            # Treesitter
            nvim-treesitter.withAllGrammars

            # Kickstart extras (enabled in your config)
            indent-blankline-nvim   # indent_line
            nvim-autopairs          # autopairs
        ];

        # ---------------------------------------------------------------------------
        # Lua config — everything from init.lua, with the lazy.nvim bootstrap and
        # require('lazy').setup(...) replaced by direct plugin setup calls.
        # ---------------------------------------------------------------------------
        initLua = ''
            -- Set <space> as the leader key
            vim.g.mapleader = ' '
            vim.g.maplocalleader = ' '

            -- Set to true if you have a Nerd Font installed and selected in the terminal
            vim.g.have_nerd_font = true

            -- [[ Setting options ]]
            vim.o.number = true
            vim.o.tabstop = 4
            vim.o.shiftwidth = 4
            vim.o.expandtab = true
            vim.o.mouse = 'a'
            vim.o.showmode = false
            vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)
            vim.o.breakindent = true
            vim.o.undofile = true
            vim.o.ignorecase = true
            vim.o.smartcase = true
            vim.o.signcolumn = 'yes'
            vim.o.updatetime = 250
            vim.o.timeoutlen = 300
            vim.o.splitright = true
            vim.o.splitbelow = true
            vim.o.list = true
            vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
            vim.o.inccommand = 'split'
            vim.o.cursorline = true
            vim.o.scrolloff = 10
            vim.o.confirm = true

            -- [[ Basic Keymaps ]]
            vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

            -- Diagnostic config
            vim.diagnostic.config {
                update_in_insert = false,
                severity_sort = true,
                float = { border = 'rounded', source = 'if_many' },
                underline = { severity = { min = vim.diagnostic.severity.WARN } },
                virtual_text = true,
                virtual_lines = false,
                jump = { float = true },
            }

            vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
            vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

            -- Window navigation
            vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
            vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
            vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
            vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

            -- Highlight on yank
            vim.api.nvim_create_autocmd('TextYankPost', {
                desc = 'Highlight when yanking (copying) text',
                group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
                callback = function() vim.hl.on_yank() end,
            })

            -- ==========================================================================
            -- Plugin setup
            -- ==========================================================================

            -- gitsigns
            require('gitsigns').setup {
                signs = {
                    add          = { text = '+' },
                    change       = { text = '~' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                },
            }

            -- markview
            require('markview').setup {}

            -- which-key
            require('which-key').setup {
                delay = 0,
                icons = { mappings = vim.g.have_nerd_font },
                spec = {
                    { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
                    { '<leader>t', group = '[T]oggle' },
                    { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
                    { 'gr', group = 'LSP Actions', mode = { 'n' } },
                },
            }

            -- telescope
            require('telescope').setup {
                extensions = {
                    ['ui-select'] = { require('telescope.themes').get_dropdown() },
                },
            }
            pcall(require('telescope').load_extension, 'fzf')
            pcall(require('telescope').load_extension, 'ui-select')

            local builtin = require 'telescope.builtin'
            vim.keymap.set('n', '<leader>sh', builtin.help_tags,    { desc = '[S]earch [H]elp' })
            vim.keymap.set('n', '<leader>sk', builtin.keymaps,      { desc = '[S]earch [K]eymaps' })
            vim.keymap.set('n', '<leader>sf', builtin.find_files,   { desc = '[S]earch [F]iles' })
            vim.keymap.set('n', '<leader>ss', builtin.builtin,      { desc = '[S]earch [S]elect Telescope' })
            vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
            vim.keymap.set('n', '<leader>sg', builtin.live_grep,    { desc = '[S]earch by [G]rep' })
            vim.keymap.set('n', '<leader>sd', builtin.diagnostics,  { desc = '[S]earch [D]iagnostics' })
            vim.keymap.set('n', '<leader>sr', builtin.resume,       { desc = '[S]earch [R]esume' })
            vim.keymap.set('n', '<leader>s.', builtin.oldfiles,     { desc = '[S]earch Recent Files ("." for repeat)' })
            vim.keymap.set('n', '<leader>sc', builtin.commands,     { desc = '[S]earch [C]ommands' })
            vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
                callback = function(event)
                    local buf = event.buf
                    vim.keymap.set('n', 'grr', builtin.lsp_references,              { buffer = buf, desc = '[G]oto [R]eferences' })
                    vim.keymap.set('n', 'gri', builtin.lsp_implementations,         { buffer = buf, desc = '[G]oto [I]mplementation' })
                    vim.keymap.set('n', 'grd', builtin.lsp_definitions,             { buffer = buf, desc = '[G]oto [D]efinition' })
                    vim.keymap.set('n', 'gO',  builtin.lsp_document_symbols,        { buffer = buf, desc = 'Open Document Symbols' })
                    vim.keymap.set('n', 'gW',  builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = 'Open Workspace Symbols' })
                    vim.keymap.set('n', 'grt', builtin.lsp_type_definitions,        { buffer = buf, desc = '[G]oto [T]ype Definition' })
                end,
            })

            vim.keymap.set('n', '<leader>/', function()
                builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end, { desc = '[/] Fuzzily search in current buffer' })

            vim.keymap.set('n', '<leader>s/', function()
                builtin.live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' }
            end, { desc = '[S]earch [/] in Open Files' })

            vim.keymap.set('n', '<leader>sn', function()
                builtin.find_files { cwd = vim.fn.stdpath 'config' }
            end, { desc = '[S]earch [N]eovim files' })

            -- LSP (Mason removed; servers come from extraPackages)
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc, mode)
                        mode = mode or 'n'
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end

                map('grn', vim.lsp.buf.rename,       '[R]e[n]ame')
                map('gra', vim.lsp.buf.code_action,  '[G]oto Code [A]ction', { 'n', 'x' })
                map('grD', vim.lsp.buf.declaration,  '[G]oto [D]eclaration')

                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client:supports_method('textDocument/documentHighlight', event.buf) then
                    local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
                    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })
                    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })
                    vim.api.nvim_create_autocmd('LspDetach', {
                        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                        callback = function(event2)
                        vim.lsp.buf.clear_references()
                        vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                        end,
                    })
                end

                if client and client:supports_method('textDocument/inlayHint', event.buf) then
                    map('<leader>th', function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                    end, '[T]oggle Inlay [H]ints')
                end
            end,
            })

            -- fidget (LSP status)
            require('fidget').setup {}

            -- lua_ls config
            vim.lsp.config('lua_ls', {
                on_init = function(client)
                    client.server_capabilities.documentFormattingProvider = false
                    if client.workspace_folders then
                        local path = client.workspace_folders[1].name
                        if path ~= vim.fn.stdpath 'config'
                            and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
                        then return end
                    end
                    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua or {}, {
                        runtime = {
                            version = 'LuaJIT',
                            path = { 'lua/?.lua', 'lua/?/init.lua' },
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file("", true), {
                                '$${3rd}/luv/library',
                                '$${3rd}/busted/library',
                            }),
                        },
                    })
                end,
                settings = {
                    Lua = { format = { enable = false } },
                },
            })
            vim.lsp.enable('lua_ls')
            -- Add more servers here as needed:
            -- vim.lsp.enable('rust_analyzer')
            -- vim.lsp.enable('pyright')

            -- conform (formatter)
            require('conform').setup {
                notify_on_error = false,
                format_on_save = function(bufnr)
                    local enabled_filetypes = {
                        -- lua = true,
                        -- python = true,
                    }
                    if enabled_filetypes[vim.bo[bufnr].filetype] then
                        return { timeout_ms = 500 }
                    else
                        return nil
                    end
                end,
                default_format_opts = { lsp_format = 'fallback' },
                formatters_by_ft = {
                    -- rust = { 'rustfmt' },
                    -- python = { 'isort', 'black' },
                },
            }
            vim.keymap.set("", '<leader>f', function()
                require('conform').format { async = true }
            end, { desc = '[F]ormat buffer' })

            -- blink.cmp (completion)
            require('blink.cmp').setup {
                keymap = { preset = 'default' },
                appearance = { nerd_font_variant = 'mono' },
                completion = {
                    documentation = { auto_show = false, auto_show_delay_ms = 500 },
                },
                sources = {
                    default = { 'lsp', 'path', 'snippets' },
                },
                snippets = { preset = 'luasnip' },
                fuzzy = { implementation = 'lua' },
                signature = { enabled = true },
            }

            -- catppuccin colorscheme
            require('catppuccin').setup {
                flavor = 'mocha',
            }
            vim.cmd.colorscheme 'catppuccin'

            -- todo-comments
            require('todo-comments').setup { signs = false }

            -- mini plugins
            require('mini.ai').setup {
                mappings = {
                    around_next = 'aa',
                    inside_next = 'ii',
                },
                n_lines = 500,
            }
            require('mini.surround').setup()
            require('mini.hipatterns').setup {
                highlighters = {
                    hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
                },
            }
            local statusline = require 'mini.statusline'
            statusline.setup { use_icons = vim.g.have_nerd_font }
            statusline.section_location = function() return '%2l:%-2v' end

            -- treesitter
            do
                local function treesitter_try_attach(buf, language)
                    if not vim.treesitter.language.add(language) then return end
                    vim.treesitter.start(buf, language)
                    local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil
                    if has_indent_query then
                        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end

                vim.api.nvim_create_autocmd('FileType', {
                    callback = function(args)
                        local buf, filetype = args.buf, args.match
                        local language = vim.treesitter.language.get_lang(filetype)
                        if not language then return end
                        treesitter_try_attach(buf, language)
                    end,
                })
            end

            -- indent-blankline
            require('ibl').setup()

            -- autopairs
            require('nvim-autopairs').setup {}

        '';
    };
}
