local plugins = {
  -- Tmux navigation
  {
    'christoomey/vim-tmux-navigator',
    event = "VeryLazy",
  },

  -- UI
  {
    'smoka7/hop.nvim',
    event = "VeryLazy",
    version = "*",
    config = function (_, opts)
     require('hop').setup(opts)
    end
  },

  -- Neorg
  {
    'nvim-neorg/neorg',
    build = ":Neorg sync-parsers",
    cmd = 'Neorg',
    ft = 'norg',
    opts = function ()
      return require('custom.opts.neorg')
    end,
    config = function (_, opts)
      require('neorg').setup(opts)

      vim.opt.conceallevel = 2
    end,
  },

  -- Mason
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = {
        'lua-language-server',
        'rust-analyzer',
        'codelldb',
        'gopls',
        'goimports-reviser',
        'golines',
        'delve',
        'typescript-language-server',
        'eslint_d',
        'prettier',
        'js-debug-adapter',
        'buf',
        'protolint',
      },
    },
  },

  -- Cmp
  {
    'hrsh7th/nvim-cmp',
    opts = function ()
      local M = require('plugins.configs.cmp')
      table.insert(M.sources, {name = 'copilot'})
      table.insert(M.sources, {name = 'neorg'})
      table.insert(M.sources, {name = 'crates'})
      return M
    end,
  },

  -- LSPs
  {
    'neovim/nvim-lspconfig',
    config = function ()
      require('plugins.configs.lspconfig')
      require('custom.configs.lspconfig')
    end,
  },

  -- DAP
  {
    'mfussenegger/nvim-dap',
    config = function ()
      require('custom.configs.dap')
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = 'mfussenegger/nvim-dap',
    opts = function ()
      return require('custom.opts.dapui')
    end,
    config = function (_, opts)
      require('dapui').setup(opts)
    end,
  },

  -- Null-ls
  {
    'nvimtools/none-ls.nvim',
    ft = {
      'go',
      'javascript',
      'typescript',
      'proto',
    },
    opts = function ()
      return require('custom.opts.null-ls')
    end,
  },

  -- GitHub Copilot
  {
    'zbirenbaum/copilot.lua',
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        norg = false,
        markdown = false,
      },
    },
    config = function(_, opts)
      require("copilot").setup(opts)
    end,
  },
  {
    'zbirenbaum/copilot-cmp',
    dependencies = {
      'zbirenbaum/copilot.lua',
      'hrsh7th/nvim-cmp',
    },
    event = { "InsertEnter", "LspAttach" },
    config = function (_, opts)
      require('copilot_cmp').setup(opts)
    end
  },

  -- Rust
  {
    'rust-lang/rust.vim',
    ft = 'rust',
    init = function ()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^3',
    ft = 'rust',
    config = function ()
      require('core.utils').load_mappings("rustaceanvim")
    end
  },
  {
    'saecki/crates.nvim',
    dependencies = 'hrsh7th/nvim-cmp',
    ft = { 'rust', 'toml' },
    config = function (_, opts)
      local crates = require('crates')
      crates.setup(opts)
      crates.show()
    end,
  },

  -- Go
  {
    'leoluz/nvim-dap-go',
    ft = 'go',
    config = function (_, opts)
      require('dap-go').setup(opts)
    end,
  },
  {
    'olexsmir/gopher.nvim',
    ft = 'go',
    config = function (_, opts)
      require('gopher').setup(opts)
    end,
    build = function ()
      vim.cmd([[silent! GoInstallDeps]])
    end
  },
}

return plugins

