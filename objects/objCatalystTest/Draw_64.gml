draw_line_width_color(0, window_get_height() / 2, window_get_width(), window_get_height() / 2, 3, c_red, c_red);
draw_line_width_color(window_get_width() / 2, 0, window_get_width() / 2, window_get_height(), 3, c_blue, c_blue);
Catalyst.Render(window_get_width(), window_get_height());

draw_set_halign(fa_right);
draw_set_valign(fa_middle);
draw_text(window_get_width() - 4, window_get_height() / 2, "FPS: " + string(fps) + "\nCPU: " + string(fps_real));