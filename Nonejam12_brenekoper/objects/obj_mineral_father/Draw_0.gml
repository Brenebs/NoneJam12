
if(white_timer)
{
	gpu_set_fog(true , c_white , 1,0);
}

draw_sprite_ext(sprite_index , image_index , x,y,image_xscale * scale, image_yscale * scale,image_angle,image_blend , 1);

if(white_timer)
{
	gpu_set_fog(false , c_white , 1,0);
}

if(life < life_max)
{
	draw_donut(x - 12,bbox_top,8,12,24,life/life_max,0,#8088FF,1)
}