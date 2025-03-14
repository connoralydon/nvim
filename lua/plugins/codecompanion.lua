if true then
  return {}
end
-- https://codecompanion.olimorris.dev/
return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "openai",
        },
        inline = {
          adapter = "openai",
        },
      },
      adapters = {
        my_openai = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            -- model = "gpt-4o",
            env = {
              url = "https://alfred.itools.anduril.dev/raw",
              -- api_key = "cmd:cat ~/.secrets/OPENAI_API_KEY.secret",
            },
            schema = {
              model = {
                default = "gpt-4o",
              },
            },
            temperature = {
              order = 2,
              mapping = "parameters",
              type = "number",
              optional = true,
              default = 0.8,
              desc = "What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. We generally recommend altering this or top_p but not both.",
              validate = function(n)
                return n >= 0 and n <= 2, "Must be between 0 and 2"
              end,
            },
            max_completion_tokens = {
              order = 3,
              mapping = "parameters",
              type = "integer",
              optional = true,
              default = nil,
              desc = "An upper bound for the number of tokens that can be generated for a completion.",
              validate = function(n)
                return n > 0, "Must be greater than 0"
              end,
            },
            stop = {
              order = 4,
              mapping = "parameters",
              type = "string",
              optional = true,
              default = nil,
              desc = "Sets the stop sequences to use. When this pattern is encountered the LLM will stop generating text and return. Multiple stop patterns may be set by specifying multiple separate stop parameters in a modelfile.",
              validate = function(s)
                return s:len() > 0, "Cannot be an empty string"
              end,
            },
            logit_bias = {
              order = 5,
              mapping = "parameters",
              type = "map",
              optional = true,
              default = nil,
              desc = "Modify the likelihood of specified tokens appearing in the completion. Maps tokens (specified by their token ID) to an associated bias value from -100 to 100. Use https://platform.openai.com/tokenizer to find token IDs.",
              subtype_key = {
                type = "integer",
              },
              subtype = {
                type = "integer",
                validate = function(n)
                  return n >= -100 and n <= 100, "Must be between -100 and 100"
                end,
              },
            },
          })
        end,
      },
    })
  end,
}
