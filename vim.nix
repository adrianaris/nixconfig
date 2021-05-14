with import <nixpkgs> {};

vim_configurable.customize {
    # Specifies the vim binary name.
    # E.g. set this to "my-vim" and you need to type "my-vim" to open this vim
    # This allows to have multiple vim packages installed (e.g. with a different set of plugins)
    name = "vim";
    vimrcConfig.customRC = ''
        # Here one can specify what usually goes into `~/.vimrc` 
        syntax enable
	## General
	set number			# Show line numbers
	set linebreak			# Break lines at word (requires Wrap lines)
	set showbreak=+++		# Wrap-broken line prefix
	set textwidth=100		# Line wrap (number of cols)
	set showmatch			# Highlight matching brace
	set visualbell			# Use visual bell (no beeping)
	 
	set hlsearch			# Highlight all search results
	set smartcase			# Enable smart-case search
	set ignorecase			# Always case-insensitive
	set incsearch			# Searches for strings incrementally
	 
	set autoindent			# Auto-indent new lines
	set shiftwidth=4		# Number of auto-indent spaces
	set smartindent			# Enable smart-indent
	set smarttab			# Enable smart-tabs
	set softtabstop=4		# Number of spaces per Tab
	 
	## Advanced
	set ruler			# Show row and column ruler information
	 
	set undolevels=1000		# Number of undo levels
	set backspace=indent,eol,start	# Backspace behaviour
    '';
    # Use the default plugin list shipped with nixpkgs
    vimrcConfig.vam.knownPlugins = pkgs.vimPlugins;
    vimrcConfig.vam.pluginDictionaries = [
	{ names = [
	    # Here you can place all your vim plugins
	    # They are installed managed by 'vam' (a vim plugin manager)
	    "Syntastic"
	    "ctrlp"
   	]; }
    ];
}
