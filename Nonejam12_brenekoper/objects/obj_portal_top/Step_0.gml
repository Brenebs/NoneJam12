
r_spd = lerp(r_spd, (((!CURRENT_WORLD or (obj_player.state == obj_player.state_prepare_fall)) * 180) - r) * 0.5, .2);

r += r_spd;