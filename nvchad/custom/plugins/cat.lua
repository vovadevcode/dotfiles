local present, cat = pcall(require, "catppuccin")

if not present then
  return
end

local options = {
  transparency = true,
  term_colors = true,
  -- styles = {
  --   comments = "italic",
  --   functions = "italic",
  --   keywords = "italic",
  --   strings = "NONE",
  --   variables = "NONE"
  -- },
  styles = {
    comments = "italic",
    functions = "NONE",
    keywords = "NONE",
    strings = "NONE",
    variables = "NONE",
  },
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = "italic",
        hints = "italic",
        warnings = "italic",
        information = "italic",
      },
      underlines = {
        errors = "underline",
        hints = "underline",
        warnings = "underline",
        information = "underline",
      },
    },
    lsp_trouble = true,
    lsp_saga = true,
    gitgutter = true,
    gitsigns = true,
    telescope = true,
    nvimtree = {
      enabled = true,
      show_root = true,
    },
    which_key = true,
    indent_blankline = {
      enabled = false,
      colored_indent_levels = false,
    },
    dashboard = true,
    neogit = false,
    vim_sneak = false,
    fern = false,
    barbar = false,
    bufferline = true,
    markdown = false,
    lightspeed = false,
    ts_rainbow = true,
    hop = true,
  },
}
cat.setup(options)
