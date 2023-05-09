#  unstable = import <unstable> {};

#  jsxpretty= pkgs.vimUtils.buildVimPlugin {
#    name = "vim-jsx-pretty";
#    src = pkgs.fetchFromGitHub {
#      owner = "MaxMEllon";
#      repo = "vim-jsx-pretty";
#      rev = "6989f1663cc03d7da72b5ef1c03f87e6ddb70b41";
#      sha256 = "16d76jvfb1cq591i06fnmgzv0q16g89zz7cmvgvj24vap2wgkbp8";
#    };
#  };
#  rest-nvim = pkgs.vimUtils.buildVimPlugin {
#    name = "rest.nvim";
#    src = pkgs.fetchFromGitHub {
#      owner = "NTBBloodbath";
#      repo = "rest.nvim";
#      rev = "58a62d9372dcefde65d50914362414b3ef0f1595";
#      sha256 = "1ksrknrvc8mgrpd0ksbmpzwnjbchp2n2rzmbav9a9138m5hxl5p4";
#    };
#  };


{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.modules.editors.vim;
in {
  options.modules.editors.nvim = {
    enable = mkEnableOption "nvim";
  };

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      vimAlias = true;
      configure = {
          packages.myPlugins = with pkgs.vimPlugins; {
            start = [ 
              vim-nix 
              vim-lastplace 
              nerdtree
              emmet-vim
              airline
              fzf-vim
              coc-nvim coc-tsserver coc-json coc-pairs
              coc-html coc-prettier coc-eslint coc-css
              coc-jest coc-git
              # plenary-nvim
              # rest-nvim
            ]; 
            opt = [];
          };
          customRC = ''
            syntax on
            set number	
            set linebreak	
            set showbreak=+++ 	
            set textwidth=100
            set showmatch	
            set visualbell
            set hidden
            set cmdheight=2
            set updatetime=300

            set mouse=a
             
            set hlsearch
            set smartcase
            set ignorecase
            set incsearch
             
            set expandtab
            set autoindent
            set shiftwidth=2
            set smartindent
            set smarttab
            set softtabstop=2
            set ruler	

            set clipboard=unnamedplus

            command Exec set splitright | vnew | set filetype=sh | read !sh #
             
            set undolevels=1000
            set backspace=indent,eol,start

            tnoremap <Esc> <C-\><C-n>
            tnoremap <A-h> <C-\><C-N><C-w>h
            tnoremap <A-j> <C-\><C-N><C-w>j
            tnoremap <A-k> <C-\><C-N><C-w>k
            tnoremap <A-l> <C-\><C-N><C-w>l
            tnoremap <A-+> <C-\><C-N><C-w>+
            inoremap <A-h> <C-\><C-N><C-w>h
            inoremap <A-j> <C-\><C-N><C-w>j
            inoremap <A-k> <C-\><C-N><C-w>k
            inoremap <A-l> <C-\><C-N><C-w>l
            inoremap <A-+> <C-\><C-N><C-w>+
            nnoremap <A-h> <C-w>h
            nnoremap <A-j> <C-w>j
            nnoremap <A-k> <C-w>k
            nnoremap <A-l> <C-w>l
            nnoremap <A-+> <C-\><C-N><C-w>+

           " Use clipboard as default register
            if system('uname -s') == "Darwin\n"
              set clipboard=unnamed "OSX
            else
              set clipboard=unnamedplus "Linux
            endif 


            let NERDTreeShowHidden=1

            inoremap <silent><expr> <TAB>
              \ pumvisible() ? "\<C-n>" :
              \ <SID>check_back_space() ? "\<TAB>" :
              \ coc#refresh()
            inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
            
            function! s:check_back_space() abort
              let col = col('.') - 1
              return !col || getline('.')[col - 1] =~# '\s'
            endfunction
            
            if has('nvim')
              inoremap <silent><expr> <c-space> coc#refresh()
            else
              inoremap <silent><expr> <c-@> coc#refresh()
            endif
            
            inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                          \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

            nnoremap <silent> K :call <SID>show_documentation()<CR>
            function! s:show_documentation()
              if (index(['vim', 'help'], &filetype) >= 0)
                execute 'h '.expand('<cword>')
              elseif (coc#rpc#ready())
                call CocActionAsync('doHover')
              else
                execute '!' . &keywordprg . " " . expand('<cword>')
              endif
            endfunction

            autocmd CursorHold * silent call CocActionAsync('highlight')
          '';
        };
    };
  };
}

