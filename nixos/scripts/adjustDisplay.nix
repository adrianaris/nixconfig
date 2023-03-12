with import <nixpkgs> {};

writeShellScriptBin "adjustDisplay.sh" ''
  #!/bin/sh
  xrandr --output DVI-D-0 --scale 2x2
  xrandr --output DVI-D-0 --scale 1.4x1.4 --output HDMI-0 --primary --pos 2688x0 
''
