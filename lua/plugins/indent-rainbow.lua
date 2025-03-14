return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = function(_, opts)
    -- Other blankline configuration here
    return require("indent-rainbowline").make_opts(opts, {
      -- How transparent should the rainbow colors be. 1 is completely opaque, 0 is invisible. 0.07 by default
      color_transparency = 0.2,
      -- The 24-bit colors to mix with the background. Specified in hex.
      { 0xA4036F, 0x048BA8, 0xEFEA5A },
      -- colors = { 0xff0000, 0x00ff00, 0x0000ff },
    })
  end,
  dependencies = {
    "TheGLander/indent-rainbowline.nvim",
  },
}
