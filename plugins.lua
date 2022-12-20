-- This file can be loaded by calling `lua require('plugins')` from your init.vim

vim.cmd [[
  packadd packer.nvim
]]
  --packadd! cfilter
  --packadd! termdebug


return require('packer').startup(function()
--  use 'wbthomason/packer.nvim'

  -- Plugins can have dependencies on other plugins

  use {
    'haorenW1025/completion-nvim',
    opt = true,
    requires = {{'hrsh7th/vim-vsnip', opt = true}, {'hrsh7th/vim-vsnip-integ', opt = true}}
  }

  -- Post-install/update hook with call of vimscript function with argument
  use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }

  -- Use dependency and run lua function after load
  use {
    'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup() end
  }

  use {'nvim-treesitter/nvim-treesitter',  run = ':TSUpdate'}

  use 'tjdevries/colorbuddy.vim'

  use 'github/copilot.vim'

  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
end)
