
if(white_timer)
{
	gpu_set_fog(true , c_white , 1,0);
}

draw_sprite_ext(sprite_index , image_index , x,y,image_xscale * scale, image_yscale * scale,1,image_blend , 1);

if(white_timer)
{
	gpu_set_fog(false , c_white , 1,0);
}