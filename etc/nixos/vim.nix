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
      vimAlias = true;
      configure = {
        packages.myPlugins = with pkgs.vimPlugins; {
          start = [ vim-lastplace vim-nix ]; 
          opt = [];
        };
        customRC = ''
          set number 
        '';
      };
    }
  )
];
}

