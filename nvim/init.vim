set number
filetype on
filetype indent on
filetype plugin on

set encoding=UTF-8
syntax on
set nocompatible
set hlsearch
set number relativenumber
set laststatus=2
set vb
set spelllang=en_us
set autoindent
set ruler
set mouse=a
set noscrollbind
set wildmenu
set autochdir
set expandtab
set tabstop=2
set shiftwidth=2
set clipboard+=unnamedplus


lua vim.g.mapleader = ','

nnoremap <leader>v :e $MYVIMRC<CR>

" Config Kube exam
" set expandtab
" set number
" set tabstop=2
" set shiftwidth=2
" syntax on
" filetype indent on

" Mouvement
" Vim 
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l


" Lua pluging init
lua require('plugins')

" Lua config
lua require('keys')
lua require('go').config.update_tool('quicktype', function(tool) tool.pkg_mgr = 'npm' end)
" Snips
lua require("luasnip.loaders.from_vscode").lazy_load()
lua require('snippets')

lua require("nvim-tree").setup()
lua require('telescope').load_extension('fzf')
lua require('lualine').setup {options = {theme = 'gruvbox-flat'}}
"lua require("nvim-lsp-installer").setup {}
lua << EOF
require("mason").setup {
	ui = { 
		icons = { 
			package_installed = "✓", 
			package_pending = "➜", 
			package_uninstalled = "✗" 
			}
		}
	} 
require("mason-lspconfig").setup {
		ensure_installed = { 
			"sumneko_lua", 
			"pyright",
			"bashls",
			"gopls",
			"jsonls",
      "tflint",
      "yamlls"
		}
	}
EOF
lua require('lsp-cmp')
lua require("nvim-treesitter.configs").setup {highlight={enable = true, additional_vim_regex_highlighting = false}}
lua require("toggleterm").setup {float_opts={width=100 , height=80 , winblend=3}}



" Gruvbox
lua vim.g.gruvbox_flat_style = 'hard'  -- Config need to be set before loading colorscheme
lua vim.cmd[[colorscheme gruvbox-flat]]

" Snippets
" imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

" Telescope config using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fr <cmd>lua require('telescope.builtin').oldfiles()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

lua << EOF
function osx()
	if (jit.os) == "OSX" then 
		print("Yes!")
	elseif (jit.os) == "OSX" then 
		print('NO')
	else 
		print("Error !")
	end
end
EOF


