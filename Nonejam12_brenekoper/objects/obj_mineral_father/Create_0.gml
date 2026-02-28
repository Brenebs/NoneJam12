
image_index = random(image_number);

scale = 1;
lerp_scale = 0;
angle = 0
angle_force = 0

white_timer = 0;

life_max = life;

//image_xscale = scale;
//image_yscale = scale;

mineral_drop = obj_mineral_drop_father;

var _name = object_get_name(object_index);
var _split = string_split(_name,"obj_mineral");

if(array_length(_split) > 1)
{
	var _drop_name = "obj_mineral_drop"+_split[1];

	//show_debug_message(_drop_name);

	var _asset = asset_get_index(_drop_name)
	if(object_exists(_asset))
	{
		mineral_drop = _asset;
	}
}

destroy_function = function(_is_dash = false)
{
	
	if(UPGRADES.ext_more_drops > 0 && UPGRADES.ext_more_drops >= resistency)
	{
		mineral_number *= (UPGRADES.ext_more_drops+2) - resistency;
	}
	
	repeat(mineral_number)
	{
		var _ins = instance_create_layer(x,y,"Drops",mineral_drop);
		_ins.rarity = resistency;
		
		if(_is_dash)
		{
			_ins.player_dash = true;
			_ins.timer_to_be_collected *= .75;
			_ins.speed*=1.5;
			
		}
	}
	
	sfx_play([snd_ore_destroy1, snd_ore_destroy2]);
	
	instance_destroy();
}

draw_mineral = function()
{
	
	draw_sprite_ext(sprite_index , 1 , x,y,image_xscale * scale, image_yscale * scale,image_angle+angle,image_blend , 1);

	draw_sprite_ext(sprite_index , 0 , x,y,image_xscale * scale, image_yscale * scale,image_angle+angle,image_blend , 1);
	
	if(white_timer)
	{
		gpu_set_fog(true , c_white , 1,0);
		
		draw_sprite_ext(sprite_index , 0 , x,y,image_xscale * scale, image_yscale * scale,image_angle+angle,image_blend , .5);
	
		gpu_set_fog(false , c_white , 1,0);
	}
}

draw_life = function()
{
	if(life < life_max)
	{
		draw_donut(x - 12,bbox_top,8,12,24,life/life_max,0,#8088FF,1)
	}
}