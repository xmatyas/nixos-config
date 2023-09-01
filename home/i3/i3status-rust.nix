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
      block = "cpu";
      interval = 1;
     }
     {
      block = "memory";
      format = " $icon $mem_total_used_percents ";
      format_alt = " $icon_swap $swap_used_percents ";
     }
     {
      block = "time";
      interval = 60;
      format = " $timestamp.datetime(f:'%m-%d %H:%M:%S') ";
     }
    ];
    theme = "plain";
    icons = "material-nf";
   };
  };
 };
}
