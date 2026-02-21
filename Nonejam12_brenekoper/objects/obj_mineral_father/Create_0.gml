
image_index = random(image_number);

scale = 1;

white_timer = 0;

//image_xscale = scale;
//image_yscale = scale;

life = 10;

mineral_drop = obj_mineral_drop_father;
mineral_number = 5;

resistency = 1;

destroy_function = function()
{
	repeat(mineral_number)
	{
		instance_create_depth(x,y,depth-50,mineral_drop);
	}
	
	instance_destroy();
}