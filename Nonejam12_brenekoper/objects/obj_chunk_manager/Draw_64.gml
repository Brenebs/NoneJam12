
draw_set_halign(fa_right);

GAME_INFO.max_chunk_achiev = max(GAME_INFO.max_chunk_achiev , player_current_chunk);

draw_text(GUI_WIDTH-20,20,$"chunk = {player_current_chunk}");
draw_text(GUI_WIDTH-20,40,$"max chunk = {GAME_INFO.max_chunk_achiev}");

draw_set_halign(fa_left);