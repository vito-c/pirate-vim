return {
  "nvim-tree/nvim-web-devicons",
  config = function()
    require("nvim-web-devicons").setup {
      override = {
        ["init.lua"] = {
          icon = "",
          color = "#98c379",
          name = "NeovimIcon",
        },
      },
    }
  end,
}
