
if(white_timer)
{
	gpu_set_fog(true , c_white , 1,0);
}

draw_sprite_ext(sprite_index , image_index , x,y,image_xscale * scale, image_yscale * scale,image_angle,image_blend , 1);

if(white_timer)
{
	gpu_set_fog(false , c_white , 1,0);
}