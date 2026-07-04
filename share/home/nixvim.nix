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

            # Telescope runtime deps
            ripgrep
            fd

            # Treesitter needs a C compiler to build parsers
            gcc
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
                    spec = [
                        {
                            __unkeyed = "<leader>s";
                            group = "[S]earch";
                            mode = [
                                "n"
                                "v"
                            ];
                        }
                        {
                            __unkeyed = "<leader>t";
                            group = "[T]oggle";
                        }
                        {
                            __unkeyed = "<leader>h";
                            group = "Git [H]unk";
                            mode = [
                                "n"
                                "v"
                            ];
                        }
                        {
                            __unkeyed = "gr";
                            group = "LSP Actions";
                            mode = [ "n" ];
                        }
                    ];
                };
            };

            # Fuzzy finder
            telescope = {
                enable = true;
                extensions.fzf-native.enable = true;
                extensions.ui-select.enable = true;
            };

            # LSP
            lspconfig.enable = true;
            fidget = {
                enable = true;
                settings = { };
            };

            # Formatter
            conform-nvim = {
                enable = true;
                settings = {
                    notify_on_error = false;
                    default_format_opts.lsp_format = "fallback";
                    format_on_save.__raw = ''
            function(bufnr)
                local enabled_filetypes = { }
                if enabled_filetypes[vim.bo[bufnr].filetype] then
                    return { timeout_ms = 500 }
                else
                    return nil
                end
            end
            '';
                    formatters_by_ft = { };
                };
            };

            # Completion
            blink-cmp = {
                enable = true;
                settings = {
                    keymap.preset = "default";
                    appearance.nerd_font_variant = "mono";
                    completion = {
                        documentation.auto_show = false;
                        documentation.auto_show_delay_ms = 500;
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
            mini-icons.enable = true;
            web-devicons.enable = true;

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
        colorschemes.catppuccin.enable = true;

        # ---------------------------------------------------------------------------
        # Globals
        # ---------------------------------------------------------------------------
        globals = {
            mapleader = " ";
            maplocalleader = " ";
            have_nerd_font = true;
        };

        # ---------------------------------------------------------------------------
        # Options
        # ---------------------------------------------------------------------------
        opts = {
            number = true;
            tabstop = 4;
            shiftwidth = 4;
            expandtab = true;
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
        };

        opts.listchars = {
            tab = "» ";
            trail = "·";
            nbsp = "␣";
        };

        clipboard = {
            # unnamedplus is set via extraConfigLuaPre to avoid race conditions
            # See the "unnamedplus" section below
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

        # ---------------------------------------------------------------------------
        # Keymaps
        # ---------------------------------------------------------------------------
        keymaps = [
            # Basic
            {
                mode = "n";
                key = "<Esc>";
                action = "<cmd>nohlsearch<CR>";
            }
            {
                mode = "t";
                key = "<Esc><Esc>";
                action = "<C-\\><C-n>";
                options.desc = "Exit terminal mode";
            }
            # Diagnostic quickfix
            {
                mode = "n";
                key = "<leader>q";
                action.__raw = "vim.diagnostic.setloclist";
                options.silent = true;
                options.desc = "Open diagnostic [Q]uickfix list";
            }
            # Window navigation
            {
                mode = "n";
                key = "<C-h>";
                action = "<C-w><C-h>";
                options.desc = "Move focus to the left window";
            }
            {
                mode = "n";
                key = "<C-l>";
                action = "<C-w><C-l>";
                options.desc = "Move focus to the right window";
            }
            {
                mode = "n";
                key = "<C-j>";
                action = "<C-w><C-j>";
                options.desc = "Move focus to the lower window";
            }
            {
                mode = "n";
                key = "<C-k>";
                action = "<C-w><C-k>";
                options.desc = "Move focus to the upper window";
            }
            # Format buffer
            {
                mode = "";
                key = "<leader>f";
                action.__raw = "function() require('conform').format { async = true } end";
                options.desc = "[F]ormat buffer";
            }
        ];

        # ---------------------------------------------------------------------------
        # Autocommands
        # ---------------------------------------------------------------------------
        autoCmd = [
            # Highlight on yank
            {
                event = "TextYankPost";
                group = "kickstart-highlight-yank";
                callback.__raw = "vim.hl.on_yank";
                desc = "Highlight when yanking (copying) text";
            }
        ];

        autoGroups = {
            kickstart-highlight-yank = {
                clear = true;
            };
        };

        # ---------------------------------------------------------------------------
        # Lua configuration
        # ---------------------------------------------------------------------------
        extraConfigLuaPre = ''
      -- Set clipboard after a scheduler tick to ensure vim is fully initialised
      vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)
      '';

        extraConfigLua = ''
      -- [[ Telescope keymaps ]]
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

      -- Telescope LSP keymaps (on LspAttach)
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

      -- Custom Telescope keymaps
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

      -- [[ LSP keymaps (on LspAttach) ]]
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

      -- [[ Plugin setup ]]

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

      -- telescope setup (theme for ui-select extension)
      require('telescope').setup {
          extensions = {
              ['ui-select'] = require('telescope.themes').get_dropdown(),
          },
      }
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- LSP (Mason removed; servers come from extraPackages)
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

      -- catppuccin colorscheme
      require('catppuccin').setup {
          flavor = 'mocha',
      }
      vim.cmd.colorscheme 'catppuccin'

      -- todo-comments
      require('todo-comments').setup {}

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

      -- Fix minuet is_available for local llama.cpp (no API key needed)
      do
          local ok, backend = pcall(require, 'minuet.backends.openai_fim_compatible')
          if ok then
              backend.is_available = function()
                  return true
              end
          end
      end
      '';
    };
}
