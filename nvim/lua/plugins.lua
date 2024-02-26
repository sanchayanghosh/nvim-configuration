vim.cmd [[packadd packer.nvim]]

vim.fn.sign_define('DapBreakpoint',{ text ='⚫', texthl ='', linehl ='', numh=''})
vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})
vim.fn.sign_define('DapBreakpointCondition', { text='ﳁ', texthl='', linehl='', numhl=''})

-- vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
-- vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
-- vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
-- vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
-- vim.keymap.set('v', '<Leader>B', function() require('dap').toggle_breakpoint() end)
-- vim.keymap.set('v', '<Leader>b', function() require('dap').set_breakpoint() end)
-- vim.keymap.set('v', '<Leader>r', function() require('dap').repl.open() end)
-- vim.keymap.set('n', '<Leader>l', function() require('dap').run_last() end)
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
      			require('dap.ui.widgets').hover()
    		end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
      			require('dap.ui.widgets').preview()
    		end)
vim.keymap.set('v', '<Leader>df', function()
      			local widgets = require('dap.ui.widgets')
      			widgets.centered_float(widgets.frames)
    		end)
vim.keymap.set('v', '<Leader>ds', function()
      			local widgets = require('dap.ui.widgets')
      			widgets.centered_float(widgets.scopes)
		end)
 

require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Install Stautsline
  use 'beauwilliams/statusline.lua'

  -- Simple plugins can be specified as strings
  use 'rstacruz/vim-closer'

  -- Lazy loading:
  -- Load on specific commands
  use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

  -- Load on an autocommand event
  use {'andymass/vim-matchup', event = 'VimEnter'}

  -- Load on a combination of conditions: specific filetypes or commands
  -- Also run code after load (see the "config" key)
  use {
    'w0rp/ale',
    ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
    cmd = 'ALEEnable',
    config = 'vim.cmd[[ALEEnable]]'
  }

  -- Plugins can have dependencies on other plugins
  -- use {
  --   'haorenW1025/completion-nvim',
  --   opt = true,
  --   requires = {{'hrsh7th/vim-vsnip', opt = true}, {'hrsh7th/vim-vsnip-integ', opt = true}}

  -- Plugins can also depend on rocks from luarocks.org:

  -- You can specify rocks in isolation
  use_rocks 'penlight'
  use_rocks {'lua-resty-http', 'lpeg'}

  -- Local plugins can be included

  -- Plugins can have post-install/update hooks
  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}

  -- Post-install/update hook with neovim command
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Post-install/update hook with call of vimscript function with argument
  use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }

  -- Use specific branch, dependency and run lua file after load
  use {
    'glepnir/galaxyline.nvim', branch = 'main', config = function() require'statusline' end,
    requires = {'kyazdani42/nvim-web-devicons'}
  }

  -- Use dependency and run lua function after load
  use {
    'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup() end
  }

  -- You can specify multiple plugins in a single call
  use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}

  -- You can alias plugin names
  use {'dracula/vim', as = 'dracula'}

  use {'Shougo/deoplete.nvim'}

  use {'zchee/deoplete-jedi', requires = { 'Shougo/deoplete.nvim' },ft={"python"}}

  use {'vim-airline/vim-airline'}
  use {'sbdchd/neoformat'}
  use {'davidhalter/jedi-vim',ft={"python"}}
  use {'scrooloose/nerdtree'}
  use {'neomake/neomake'}
  use {'terryma/vim-multiple-cursors'}
  use {'machakann/vim-highlightedyank'}
  use {'tmhedberg/SimpylFold'}
  use {'jiangmiao/auto-pairs'}
  use {'jreybert/vimagit'}

  use {
	  'numToStr/Comment.nvim',
	  config = function()
		  require('Comment').setup()
	  end
  }
  use {
	'mfussenegger/nvim-dap',
	config = function()
		require('dap.ext.vscode').load_launchjs('.nvim/launch.json', {})


	end
  }
  
  use {
	'leoluz/nvim-dap-go',
	config = function()
		require('dap-go').setup()
	end,
	ft={"go"}
  }

  use {
	 "rcarriga/nvim-dap-ui",
	requires = {"mfussenegger/nvim-dap"},
	config = function()
		local dap, dapui = require('dap'),require('dapui')
		dapui.setup()
		dap.listeners.after.event_initialized["dapui_config"]=function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"]=function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"]=function()
			dapui.close()
		end
	end

  }

  use {
	  'mfussenegger/nvim-dap-python',
	  requires = {"mfussenegger/nvim-dap"},
	  config = function()
		  	require('dap-python').setup()
		end
  }

  -- use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin

  use {
	-- 'neovim/nvim-lspconfig',
	'bob@127.0.0.1:/mnt/5a257e09-2112-4140-b6d0-529977714705/testpython/lua-config/nvim-lspconfig',
	config = function()
		-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'nixd' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
  
  end
  }


end)


