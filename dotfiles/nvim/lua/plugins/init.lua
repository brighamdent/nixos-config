return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
        "gofumpt",
        "gopls",
        "pyright",
        "nixfmt",
        "rnix-lsp",
        "eslint-lsp",
        "fixjson",
        "typescript-language-server",
        "black",
        "shfmt"
      },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {

      view = {
        relativenumber = true,
        float = {
          enable = true,
          open_win_config = function()
            local screen_w = vim.opt.columns:get()
            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
            local window_w = screen_w * 0.3
            local window_h = screen_h * 0.8
            local window_w_int = math.floor(window_w)
            local window_h_int = math.floor(window_h)
            local center_x = (screen_w - window_w) / 2
            local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
            return {
              border = "rounded",
              relative = "editor",
              row = center_y,
              col = center_x,
              width = window_w_int,
              height = window_h_int,
            }
          end,
        },
        width = function()
          return math.floor(vim.opt.columns:get() * 0.8)
        end,
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      indent = { enable = true },
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "markdown",
        "markdown_inline",
      },
    },
  },
  {
    "altermo/ultimate-autopair.nvim",
    -- event = { "InsertEnter", "CmdlineEnter" },
    lazy = false,
    branch = "v0.6", --recomended as each new version will have breaking changes
    opts = {
      map_cr = true,
      --Config goes here
    },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local cmp = require "cmp"
      cmp.setup.filetype({ "sql" }, {
        sources = {
          { name = "vim-dadbod-completion" },
          { name = "buffer" },
        },
      })
    end,

    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        config = function(_, opts)
          -- load default luasnip config;
          -- require("plugins.configs.others").luasnip(opts)

          local luasnip = require "luasnip"
          luasnip.filetype_extend("javascriptreact", { "html" })
          luasnip.filetype_extend("typescriptreact", { "react-ts", "typescript", "html" })
          luasnip.filetype_extend("javascriptreact", { "react", "javascript", "html" })
          luasnip.filetype_extend("javascript", { "react" })
          luasnip.filetype_extend("vue", { "html" })
          require("luasnip/loaders/from_vscode").lazy_load()
        end,
      },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    lazy = false,
  },
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup {
        cursor_scrolls_alone = false,
        mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "zt", "zz", "zb" },
      }
    end,
    lazy = false,
  },
  {
    "tpope/vim-surround",
    lazy = false,
  },
  {
    "ThePrimeagen/vim-be-good",
    cmd = "VimBeGood",
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
    config = function()
      require("rainbow-delimiters.setup").setup {
        strategy = {
          -- ...
        },
        query = {
          -- ...
        },
        highlight = {
          "RainbowDelimiterPurple",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          -- "RainbowDelimiterViolet",
          -- "RainbowDelimiterCyan",
        },
      }
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = false,
  },
  {
    "numToStr/Comment.nvim",
    lazy = false,
    dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
      require("Comment").setup {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
  },
  {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    lazy = false,
  },
  {
    "nvim-lua/plenary.nvim",
  },
  {
    "edluffy/hologram.nvim",
    lazy = false,
  },
  {
    "MunifTanjim/nui.nvim",
    lazy = false, -- force load immediately
  },
  {
    "folke/noice.nvim",
    lazy = true,
    event = "VeryLazy",

    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        config = function()
          require("notify").setup {
            background_colour = "#000000",
          }
        end,
      },
    },
    config = function()
      require("noice").setup {
        lsp = {
          hover = {
            enabled = false,
          },
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          signature = {
            enabled = false,
          },
        },
        -- hover = {
        --   enabled = false,
        -- },
        routes = {
          {
            filter = { event = "msg_show" },
            view = "notify",
          },
        },
        messages = {
          enabled = true,
          view = "notify", -- show normal messages via notify
          -- you can also filter or format if needed
        },
        presets = {
          -- bottom_search = true,         -- use a classic bottom cmdline for search
          -- command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = true, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true, -- add a border to hover docs and signature help
        },
      }
    end,
  },
  {
    "tpope/vim-dadbod",
    cmd = {
      "DB",
    },
  },
  {
    "NeogitOrg/neogit",
    cmd = { "Neogit" },
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua", -- optional
      "echasnovski/mini.pick", -- optional
    },
    config = true,
  },
  {
    "smjonas/inc-rename.nvim",
    lazy = false,
    opts = {
      cmd_name = "Rename",
    },
  },
  {
    "debugloop/telescope-undo.nvim",
    dependencies = { -- note how they're inverted to above example
      {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    keys = {
      { -- lazy style key map
        "<leader>u",
        "<cmd>Telescope undo<cr>",
        desc = "undo history",
      },
    },
    opts = {
      -- don't use `defaults = { }` here, do this in the main telescope spec
      extensions = {
        undo = {
          -- telescope-undo.nvim config, see below
        },
        -- no other extensions here, they can have their own spec too
      },
    },
    config = function(_, opts)
      -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
      -- configs for us. We won't use data, as everything is in it's own namespace (telescope
      -- defaults, as well as each extension).
      require("telescope").setup(opts)
      require("telescope").load_extension "undo"
    end,
  },
}
