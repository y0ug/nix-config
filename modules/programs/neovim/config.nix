{ pkgs }:
{ }

# let
#   # Generate a default init.lua for users who don't have their own config
#   initLua = ''
#     -- Base configuration
#     vim.opt.number = true
#     vim.opt.relativenumber = true
#     vim.opt.autoindent = true
#     vim.opt.tabstop = 2
#     vim.opt.shiftwidth = 2
#     vim.opt.expandtab = true
#     vim.opt.smarttab = true
#     vim.opt.softtabstop = 2
#     vim.opt.mouse = 'a'
#     vim.opt.termguicolors = true
#     vim.opt.ignorecase = true
#     vim.opt.smartcase = true
#     vim.opt.clipboard = 'unnamedplus'
#     vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
#
#     -- Set leader key
#     vim.g.mapleader = ' '
#     vim.g.maplocalleader = ' '
#
#     -- Theme setup
#     vim.cmd[[colorscheme tokyonight-night]]
#
#     -- Plugin configurations
#     -- Treesitter
#     require('nvim-treesitter.configs').setup({
#       highlight = { enable = true },
#       indent = { enable = true },
#     })
#
#     -- Telescope
#     local telescope = require('telescope')
#     telescope.setup({})
#
#     -- LSP Config
#     local lspconfig = require('lspconfig')
#
#     -- Set up common servers
#     local servers = { 'pyright', 'tsserver', 'rust_analyzer', 'gopls', 'lua_ls' }
#     for _, lsp in ipairs(servers) do
#       lspconfig[lsp].setup({
#         capabilities = require('cmp_nvim_lsp').default_capabilities(),
#       })
#     end
#
#     -- nvim-cmp
#     local cmp = require('cmp')
#     local luasnip = require('luasnip')
#
#     cmp.setup({
#       snippet = {
#         expand = function(args)
#           luasnip.lsp_expand(args.body)
#         end,
#       },
#       mapping = cmp.mapping.preset.insert({
#         ['<C-Space>'] = cmp.mapping.complete(),
#         ['<CR>'] = cmp.mapping.confirm({ select = true }),
#         ['<Tab>'] = cmp.mapping(function(fallback)
#           if cmp.visible() then
#             cmp.select_next_item()
#           elseif luasnip.expand_or_jumpable() then
#             luasnip.expand_or_jump()
#           else
#             fallback()
#           end
#         end, { 'i', 's' }),
#         ['<S-Tab>'] = cmp.mapping(function(fallback)
#           if cmp.visible() then
#             cmp.select_prev_item()
#           elseif luasnip.jumpable(-1) then
#             luasnip.jump(-1)
#           else
#             fallback()
#           end
#         end, { 'i', 's' }),
#       }),
#       sources = cmp.config.sources({
#         { name = 'nvim_lsp' },
#         { name = 'luasnip' },
#         { name = 'buffer' },
#         { name = 'path' }
#       })
#     })
#
#     -- Lualine (status line)
#     require('lualine').setup({
#       options = {
#         theme = 'tokyonight',
#         component_separators = { left = '', right = ''},
#         section_separators = { left = '', right = ''},
#       }
#     })
#
#     -- Bufferline
#     require('bufferline').setup({
#       options = {
#         numbers = "none",
#         diagnostics = "nvim_lsp",
#         separator_style = "thin",
#         show_close_icon = false,
#         show_buffer_close_icons = false,
#       }
#     })
#
#     -- Gitsigns
#     require('gitsigns').setup()
#
#     -- Which-key
#     require('which-key').setup()
#
#     -- Comment.nvim
#     require('Comment').setup()
#
#     -- Autopairs
#     require('nvim-autopairs').setup({
#       check_ts = true,
#       ts_config = {
#         lua = {'string'},
#         javascript = {'template_string'},
#       }
#     })
#
#     -- Keymaps
#     -- Telescope
#     vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<CR>')
#     vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>')
#     vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<CR>')
#     vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<CR>')
#
#     -- LSP
#     vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
#     vim.keymap.set('n', 'gr', vim.lsp.buf.references)
#     vim.keymap.set('n', 'K', vim.lsp.buf.hover)
#     vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
#     vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
#     vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end)
#
#     -- Buffer navigation
#     vim.keymap.set('n', '<leader>bn', '<cmd>bnext<CR>')
#     vim.keymap.set('n', '<leader>bp', '<cmd>bprevious<CR>')
#     vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<CR>')
#   '';
# in {
#   # Return the configuration
#   defaultConfig = initLua;
#
#   # Function to write configuration to a file
#   writeDefaultConfig = pkgs.writeTextFile {
#     name = "init.lua";
#     text = initLua;
#     destination = "/etc/xdg/nvim/init.lua";
#   };
# }
