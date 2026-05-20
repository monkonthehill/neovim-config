
-- ~/.config/nvim/lua/plugins/formatting.lua
return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        stylua = {
          prepend_args = { "--indent-width", "4", "--indent-type", "Spaces" },
        },
        -- Add other formatters here as needed
      },
    },
  },
}
