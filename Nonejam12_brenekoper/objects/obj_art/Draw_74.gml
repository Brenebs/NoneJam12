
gpu_set_tex_filter(true);
draw_sprite_stretched_ext(
	sprite_index,
	image_index,
	0,
	0,
	GUI_WIDTH,
	GUI_HEIGHT,
	image_blend,
	image_alpha
);
gpu_set_tex_filter(false)