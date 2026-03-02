draw_object();

draw_sprite_ext(
	spr_portal_magnet,
	0,
	x + lengthdir_x(40 + lengthdir_x(2, current_time * .1), image_angle + 90),
	y + lengthdir_y(40 + lengthdir_x(2, current_time * .1), image_angle + 90),
	1,
	1,
	lengthdir_x(3, current_time * .066) + image_angle + r,
	image_blend,
	image_alpha
)

if(never_interact())
{
	draw_arrow_pointer();
}


