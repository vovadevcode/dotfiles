local M = {
  "rafamadriz/friendly-snippets",
  event = "InsertEnter",
  dependencies = {
    {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "onsails/lspkind-nvim",
        "hrsh7th/cmp-nvim-lsp-document-symbol",
        "hrsh7th/cmp-cmdline",
        -- "ray-x/cmp-treesitter",
      },
    },
  },
}

function M.config()
  local cmp = require "cmp"

  local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
      return false
    end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match "^%s*$" == nil
  end

  local options = {
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    completion = {
      completeopt = "menu,menuone,noinsert",
    },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    formatting = {
      format = require("lspkind").cmp_format {
        -- with_text = true,
        mode = "symbol_text",
        maxwidth = 50,
      },
    },
    mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() and has_words_before() then
          cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
          -- cmp.select_next_item()
        elseif require("luasnip").expand_or_jumpable() then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif require("luasnip").jumpable(-1) then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
    },
    sources = {
      { name = "luasnip", max_item_count = 5 },
      { name = "nvim_lsp", max_item_count = 10 },
      { name = "buffer", keyword_length = 3, max_item_count = 5 },
      { name = "nvim_lua", max_item_count = 5 },
      { name = "path" },
      { name = "crates" },
    },
  }

  cmp.setup(options)

  -- Use cmdline & path source for ':'.
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path", max_item_count = 5 },
    }, {
      { name = "cmdline", max_item_count = 15 },
    }),
  })

  -- lsp_document_symbols
  cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "nvim_lsp_document_symbol", max_item_count = 8 },
    }, {
      { name = "buffer", max_item_count = 5 },
    }),
  })

  -- vim.api.nvim_exec(
  --     [[
  --         " autocmd! FileType sql setlocal omnifunc=vim_dadbod_completion#omni
  --         autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
  --     ]],
  --     false
  --   )
end

return M