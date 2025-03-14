return {
  {
    "folke/snacks.nvim",
    -- priority = 1000,
    -- lazy = false,
    opts = function()
      ---@type snacks.Config
      return {
        -- notifier = { enabled = true },
        -- quickfile = { enabled = true },
        -- bigfile = { enabled = true },
        -- words = { enabled = true },
        -- toggle = { map = LazyVim.safe_keymap_set },
        -- statuscolumn = { enabled = false }, -- we set this in options.lua
        terminal = {
          win = {
            position = "float",
            style = "terminal",
            interactive = true,
            auto_insert = true,
          },
        },
      }
    end,
  },
}
