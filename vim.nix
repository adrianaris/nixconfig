{ pkgs, ... }:
{
  environment.variables = { EDITOR = "vim"; };

  environment.systemPackages = with pkgs; [
    (vim_configurable.customize {
      name = "mvi";
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [ vim-nix vim-lastplace ];
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
	set shiftwidth=4
	set smartindent
	set smarttab
	set softtabstop=4
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

