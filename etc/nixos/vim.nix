{ config, pkgs, ... }:

let
  jsxpretty= pkgs.vimUtils.buildVimPlugin {
    name = "vim-jsx-pretty";
    src = pkgs.fetchFromGitHub {
      owner = "MaxMEllon";
      repo = "vim-jsx-pretty";
      rev = "6989f1663cc03d7da72b5ef1c03f87e6ddb70b41";
      sha256 = "16d76jvfb1cq591i06fnmgzv0q16g89zz7cmvgvj24vap2wgkbp8";
    };
  };
in
{
  environment.variables = { EDITOR = "vim"; };

  environment.systemPackages = with pkgs; [
    (vim_configurable.customize {
      name = "mvi";
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [ 
          vim-nix 
          vim-lastplace 
          jsxpretty
          nerdtree
          emmet-vim
          airline
          fzf-vim
        ];
        opt = [];
      };
      vimrcConfig.customRC = ''
	set number	
	set linebreak	
	set showbreak=+++ 	
	set textwidth=100
	set showmatch	
	set visualbell
	 
	set hlsearch
	set smartcase
	set ignorecase
	set incsearch
	 
	set autoindent
	set shiftwidth=2
	set smartindent
	set smarttab
	set softtabstop=2
	set ruler	
	 
	set undolevels=1000
	set backspace=indent,eol,start
      '';
    }
  )
   (neovim.override {
      configure = {
        packages.myPlugins = with pkgs.vimPlugins; {
          start = [ 
            vim-nix 
            vim-lastplace 
            jsxpretty
            nerdtree
            emmet-vim
            airline
            fzf-vim
          ]; 
          opt = [];
        };
        customRC = ''
          set number	
          set linebreak	
          set showbreak=+++ 	
          set textwidth=100
          set showmatch	
          set visualbell
           
          set hlsearch
          set smartcase
          set ignorecase
          set incsearch
           
          set autoindent
          set shiftwidth=2
          set smartindent
          set smarttab
          set softtabstop=2
          set ruler	
           
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
        '';
      };
    }
  )
];
}

