local plugins = {
  ["phaazon/hop.nvim"] = {
    branch = "v2",
    config = function()
      local hop = require "hop"
      -- local directions = require("hop.hint").HintDirection
      vim.keymap.set("", "fw", function()
        hop.hint_words {}
      end, { remap = true })
      -- vim.keymap.set("", "fp", function()
      --   hop.hint_patterns {}
      -- end, { remap = true })
      hop.setup {}
    end
  },
  ["nvim-treesitter/nvim-treesitter"] = {
    -- module = "nvim-treesitter",
    requires = { "nvim-treesitter/nvim-treesitter-textobjects" },
    config = function()
      local ts = require "nvim-treesitter.configs"
      local options = {
        ensure_installed = { "lua", "python", "vim" },
        highlight = {
          enable = true,
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
            selection_modes = { "v", "V" },
            include_surrounding_whitespace = true,
          },
        },
      }
      ts.setup(options)
    end,
    --    run = ":TSUpdate",
  },
  ["nvim-tree/nvim-web-devicons"] = {},
  ["nvim-tree/nvim-tree.lua"] = {
    requires = {
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      local nvimtree = require "nvim-tree"
      local options = {
        filters = {
          dotfiles = false,
          exclude = { vim.fn.stdpath "config" .. "/lua/custom" },
        },
        disable_netrw = true,
        hijack_netrw = true,
        open_on_setup = false,
        ignore_ft_on_setup = { "alpha" },
        hijack_cursor = true,
        hijack_unnamed_buffer_when_opening = false,
        update_cwd = true,
        update_focused_file = {
          enable = true,
          update_cwd = false,
        },
        view = {
          adaptive_size = true,
          side = "left",
          width = 25,
          hide_root_folder = true,
          float = {
            enable = true,
            open_win_config = {
              relative = "win"
            }
          },
        },
        actions = {
          open_file = {
            resize_window = true,
            window_picker = {
              enable = false,
            },
          },
        },
        -- view = {
        --   adaptive_size = true,
        --   side = "left",
        --   width = 25,
        --   hide_root_folder = true,
        -- },
        git = {
          enable = false,
          ignore = true,
        },
        filesystem_watchers = {
          enable = true,
        },
        -- actions = {
        --   open_file = {
        --     resize_window = true,
        --   },
        -- },
        renderer = {
          highlight_git = false,
          highlight_opened_files = "none",

          indent_markers = {
            enable = false,
          },

          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = false,
            },

            glyphs = {
              default = "",
              symlink = "",
              folder = {
                default = "",
                empty = "",
                empty_open = "",
                open = "",
                symlink = "",
                symlink_open = "",
                arrow_open = "",
                arrow_closed = "",
              },
              git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "",
                ignored = "◌",
              },
            },
          },
        },
      }
      vim.g.nvimtree_side = options.view.side
      nvimtree.setup(options)
    end,
  },
  ["EdenEast/nightfox.nvim"] = {
    config = function()
      vim.cmd "colorscheme carbonfox"
    end
  },
  ["lukas-reineke/indent-blankline.nvim"] = {
    config = function()
      local ibl = require "indent_blankline"
      ibl.setup({
        show_end_of_line = true,
        space_char_blankline = " ",
        show_current_context = true,
        -- show_current_context_start = true,
      })
    end
  },
  -- ["ms-jpq/coq_nvim"] = {
  --   branch = "coq",
  --   run = "python3 -m coq deps"
  -- },
  -- ["ms-jpq/coq.artifacts"] = {
  --   branch = "artifacts"
  -- },
  -- ["ms-jpq/coq.thirdparty"] = {
  --   branch = "3p"
  -- },
  ["hrsh7th/nvim-cmp"] = {
    requires = { "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
    config = function()
      -- luasnip setup
      local luasnip = require 'luasnip'

      -- nvim-cmp setup
      local cmp = require 'cmp'
      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = "buffer" },
          { name = "nvim_lua" },
          { name = "path" },
        },
      }
    end
  },
  ["hrsh7th/cmp-nvim-lsp"] = {

  },
  ["L3MON4D3/LuaSnip"] = {},
  ["saadparwaiz1/cmp_luasnip"] = {},
  ["hrsh7th/cmp-buffer"] = {},
  ["hrsh7th/cmp-path"] = {},
  ["neovim/nvim-lspconfig"] = {
    requires = { "hrsh7th/cmp-nvim-lsp" },
    --    config = function()
    --     -- Use an on_attach function to only map the following keys
    --     -- after the language server attaches to the current buffer
    --     local on_attach = function(client, bufnr)
    --       -- Enable completion triggered by <c-x><c-o>
    --       vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    --
    --       -- Mappings.
    --       -- See `:help vim.lsp.*` for documentation on any of the below functions
    --       local bufopts = { noremap=true, silent=true, buffer=bufnr }
    --       -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    --       vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    --       vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    --       -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    --       vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    --       -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    --       -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    --       -- vim.keymap.set('n', '<space>wl', function()
    --       --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    --       -- end, bufopts)
    --       -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    --       -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    --       -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    --       vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    --       vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
    --     end
    --     local lsp_flags = {
    --       -- This is the default in Nvim 0.7+
    --       debounce_text_changes = 150,
    --     }
    --     -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    --     local capabilities = require"cmp_nvim_lsp".default_capabilities()
    --     local lspconfig = require "lspconfig"
    --     local servers = {"pyright"}
    --     for _, svr in ipairs(servers) do
    --       lspconfig[svr].setup {
    --         on_attach = on_attach,
    --         capabilities = capabilities,
    --         flags = lsp_flags,
    --       }
    --     end
    --   end
  },
  ["williamboman/mason.nvim"] = {
    config = function()
      require("mason").setup()
    end
  },
  ["numToStr/Comment.nvim"] = {},
  ["nvim-lua/plenary.nvim"] = {},
  ["nvim-telescope/telescope.nvim"] = {
    tag = "0.1.0",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      local ts = require "telescope"
      ts.setup()
    end,
  },
  ["nvim-lualine/lualine.nvim"] = {
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      local ll = require "lualine"
      ll.setup()
    end
  },
  ["nvim-treesitter/nvim-treesitter-textobjects"] = {},
  ["https://gitlab.com/yorickpeterse/nvim-window.git"] = {},
  ["ray-x/navigator.lua"] = {
    requires = {
      { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' },
      { 'neovim/nvim-lspconfig' },
    },
    config = function()
      local nav = require "navigator"
      nav.setup {
        mason = true,
      }
    end
  },
  ["lewis6991/gitsigns.nvim"] = {
    config = function()
      require("gitsigns").setup({
        debug_mode = true
      })
    end
  },
  ["christoomey/vim-tmux-navigator"] = {},
  ["tversteeg/registers.nvim"] = {
    config = function()
      require "registers".setup {}
    end,
  },
  ["chentoast/marks.nvim"] = {
    config = function()
      require "marks".setup({
        mappings = {
          -- preview = "mp"
          next = "mn",
          prev = "mN"
        },
      })
    end
  },
  ["declancm/windex.nvim"] = {
    config = function()
      require("windex").setup()
    end
  },
}

return plugins
