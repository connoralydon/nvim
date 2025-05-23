return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      -- {
      --   "<leader>fp",
      --   function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
      --   desc = "Find Plugin File",
      -- },
      {
        "<leader> ",
        function()
          require("telescope.builtin").find_files({ cwd = vim.fn.getcwd() })
        end,
        desc = "Find File in CWD",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        file_ignore_patterns = { "^vendor/" },
      },
    },
  },
}
