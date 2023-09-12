{
 programs.i3status-rust = {
  enable = true;
  bars = {
   top = {
    blocks = [
     {
      block = "sound";
      click = [{
       button = "left";
       cmd = "pavucontrol";
      }];
     }
     {
      block = "net";
      format = " ^icon_net_down $speed_down.eng(prefix:K) ^icon_net_up $speed_up.eng(prefix:K) ";
      inactive_format = " $icon Down ";
      missing_format = " ? Missing ";
      interval = 1;
     }
     {
      block = "cpu";
      interval = 3;
     }
     {
      block = "memory";
      format = " $icon $mem_used_percents ";
      format_alt = " $icon_swap $swap_used_percents ";
      interval = 3;
     }
     {
      block = "keyboard_layout";
      format = " $layout ";
      driver = "localebus";
     }
     {
      block = "time";
      interval = 60;
      format = " $timestamp.datetime(f:'%m-%d %H:%M') ";
     }
    ];
    theme = "plain";
    icons = "material-nf";
  };
  };
 };
}
