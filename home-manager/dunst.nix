{
  services.dunst = {
    enable = true;

    settings = {
      global = {
        width = 420;
        height = 300;

        origin = "top-right";
        offset = "10x10";

        transparency = 20;

        corner_radius = 10;
        frame_width = 0;
        gap_size = 12;
        separator_height = 0;

        padding = 18;
        horizontal_padding = 18;
        text_icon_padding = 14;

        font = "Inter 10";

        icon_position = "left";
        min_icon_size = 32;
        max_icon_size = 48;

        format = "<b>%s</b>\n%b";

        markup = "full";

        mouse_left_click = "close_current";
        mouse_right_click = "close_all";
      };

      urgency_low = {
        background = "#16161640";
        foreground = "#d9d9d9";
        timeout = 3;
      };

      urgency_normal = {
        background = "#16161640";
        foreground = "#e5e5e5";
        timeout = 6;
      };

      urgency_critical = {
        background = "#16161640";
        foreground = "#ffffff40";
        timeout = 0;
      };
    };
  };
}
