// Inherit the parent event
event_inherited();

gpu_set_tex_filter(true);

draw_sprite_ext(
	spr_logo,
	0,
	-200 + 300 * anim - 3,
	75 + 3,
	.125,
	.125,
	lengthdir_x(5, current_time * .05),
	#000000,
	1
);

draw_sprite_ext(
	spr_logo,
	0,
	-200 + 300 * anim,
	75,
	.125,
	.125,
	lengthdir_x(5, current_time * .05),
	#ffffff,
	1
);

gpu_set_tex_filter(false);