return {
  "DNLHC/glance.nvim",
  opts = {
    preview_win_opts = { relativenumber = false },
    theme = { enable = true, mode = "darken" },
  },
  keys = {
    -- { "gd", "<Cmd>Glance definitions<CR>", desc = "[G]lance [D]efinitions" },
    { "gr", "<Cmd>Glance references<CR>", desc = "[G]lance [R]eferences" },
    { "<leader>D", "<Cmd>Glance type_definitions<CR>", desc = "[G]lance type [D]efinitions" },
    { "gi", "<Cmd>Glance implementations<CR>", desc = "[G]lance [I]mplementations" },
  },
}
