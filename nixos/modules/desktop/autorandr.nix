{ pkgs, lib, config, ... }:
  with lib;
  let cfg = config.modules.desktop.autorandr;
  in
{
  options.modules.desktop.autorandr = {
    enable = mkEnableOption "autorandr";
  };

  config = lib.mkIf cfg.enable {
    programs.autorandr = {
      enable = true;
      profiles = {
        "adrianaris" = {
          config = {
            HDMI-0 = {
              enable = true;
              primary = true;
              mode = "3840x2160";
              rate = "60.00";
              position = "2688x0";
            };
            DVI-D-0 = {
              enable = true;
              mode = "1920x1200";
              rate = "60.00";
              scale = {
                x = 1.4;
                y = 1.4;
              };
              position = "0x0";
            };
          };
          fingerprint = {
            DVI-D-0 = "00ffffffffffff0010ac7aa04c3834342917010380342078eaee95a3544c99260f5054a1080081408180a940b300d1c0010101010101283c80a070b023403020360006442100001a000000ff00544b38354b3341393434384c0a000000fc0044454c4c2055323431324d0a20000000fd00323d1e5311000a202020202020005f";
            HDMI-0 =  "00ffffffffffff004c2d940f00000000291c0103804627782ace51a6574c9f26125054bfef80714f810081c081809500a9c0b300010108e80030f2705a80b0588a00b9882100001e000000fd00184b1e873c000a202020202020000000fc00553332523539780a2020202020000000ff004831414b3530303030300a20200146020334f04d611203130420221f105f605d5e23090707830100006d030c001000b83c20006001020367d85dc401788003e30f0104023a801871382d40582c4500b9882100001e023a80d072382d40102c4580b9882100001e04740030f2705a80b0588a00b9882100001e565e00a0a0a0295030203500b9882100001a000000a0";
          };
        };
      };
    };
  };
}

