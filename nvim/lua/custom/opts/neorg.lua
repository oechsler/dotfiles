local opts = {
  load = {
    ["core.defaults"] = {},
    ["core.completion"] = {
      config = {
        engine = "nvim-cmp",
      },
    },
    ["core.integrations.nvim-cmp"] = {},
    ["core.concealer"] = {
      config = {
        icon_preset = "diamond",
      },
    },
    ["core.keybinds"] = {
      config = {
        default_keybinds = true,
        neorg_leader = "<leader><leader>"
      }
    },
    ["core.dirman"] = {
      config = {
        workspaces = {
          nextcloud = "~/Nextcloud/Notizen/Neorg",
        },
        default_workspace = "nextcloud",
      },
    },
  },
}

return opts
