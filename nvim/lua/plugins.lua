return require('packer').startup(function()
	  use 'wbthomason/packer.nvim'
	  use { 'junegunn/fzf', run = ":call fzf#install()" }
	  use { 'junegunn/fzf.vim' }
	  -- Treesitter
	  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
	  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
	  use {'liuchengxu/vim-clap', run = ':Clap install-binary'}
	  use {'nvim-telescope/telescope.nvim', requires = { {'nvim-lua/plenary.nvim'} }}
	  use {'folke/which-key.nvim', config = function() require("which-key").setup{} end}
	  --color
	  use 'eddyekofo94/gruvbox-flat.nvim' 
	  -- double quote, parenthesis
	  use {'Raimondi/delimitMate'} 
	  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
	  use {'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true }}
	  -- optional, for file icons
	  use {'kyazdani42/nvim-tree.lua', requires = {'kyazdani42/nvim-web-devicons'}} 
	  -- show indent lines
	  use {'Yggdroot/indentLine'} 
    --use 'voldikss/vim-floaterm'
	  -- LSP
	  use { "williamboman/mason.nvim" }
	  use { "williamboman/mason-lspconfig.nvim" }
	  use {"neovim/nvim-lspconfig"}
	  -- Json snippets
	  use {'tamago324/nlsp-settings.nvim'}
	  -- Terreform
	  use {'hashivim/vim-terraform'}
	  -- Golang
	  use {'crispgm/nvim-go'}
	  -- Code completion
	  use {'hrsh7th/nvim-cmp'}
	  use {'hrsh7th/cmp-nvim-lsp'}
	  use {'hrsh7th/cmp-buffer'}
	  use {'hrsh7th/cmp-path'}
	  use {'saadparwaiz1/cmp_luasnip'}
	  -- Snippets
	  use {'L3MON4D3/LuaSnip',
	  	config = function() 
		  require("luasnip").config.set_config {
        	    history = true,
            	  }
            	  require("luasnip.loaders.from_vscode").load {}
        	end,}
	  use "rafamadriz/friendly-snippets"
    use {"akinsho/toggleterm.nvim", tag = 'v2.*'}
end)
