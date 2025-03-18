--
local DEV_ENV = os.getenv("DEV_ENV") -- "work" | "home"
if DEV_ENV == nil then
  print("`DEV_ENV` is unset, using 'home' as default environment. It can be 'home' or 'work'")
  DEV_ENV = "home"
end

local WORK_API_URL = os.getenv("WORK_API_URL")

--
-- guide - https://nithinbekal.com/posts/avante-nvim/
return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  opts = {
    -- add any opts here
    -- for example
    provider = "openai",
    auto_suggestions_provider = "openai",
    -- cursor_applying_provider = "openai",
    openai = {
      -- endpoint = "https://alfred.itools.anduril.dev/raw",
      -- endpoint = "https://api.openai.com/v1",
      endpoint = (((DEV_ENV == "work") and WORK_API_URL) or ((DEV_ENV == "home") and "https://api.openai.com/v1")),
      model = (
        ((DEV_ENV == "work") and "anthropic.claude-3-5-sonnet-20240620-v1:0")
        or ((DEV_ENV == "home") and "gpt-4o")
      ),
      timeout = 30000, -- timeout in milliseconds
      -- temperature = 0, -- adjust if needed
      max_tokens = 4096,
    },

    behaviour = {
      auto_suggestions = false,
      auto_apply_diff_after_generation = false,
    },
    suggestion = {
      debounce = 600,
      throttle = 600,
    },
    mappings = {
      suggestion = {
        accept = "<leader>a1",
        next = "<leader>a2",
        prev = "<leader>a3",
        dismiss = "<leader>a4",
      },
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "echasnovski/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selectorgg provider fzf
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
