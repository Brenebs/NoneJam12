
clock++;

if (clock >= time) and audio_group_is_loaded(ag_musics) and audio_group_is_loaded(ag_sfx) {
	image_alpha -= (1 / 90);
	image_alpha = clamp(image_alpha, 0, 1);
	
	if (image_alpha <= 0) {
		if !is_gone {
			instance_create_depth(0, 0, 0, obj_transition).action = fx() { change_room(rm_main_menu) };
			
			is_gone = true;
		}
	}
}
else {
	image_alpha += (1 / 90);
	image_alpha = clamp(image_alpha, 0, 1);
}