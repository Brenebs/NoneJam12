// Inherit the parent event
event_inherited();

x = room_width/2;
image_xscale = (room_width*2) / sprite_width
image_yscale = CHUNK_HEIGHT/2 / sprite_height

mineral_drop = drop;

if(GAME_INFO.max_roadblock_destroyed >= resistency)
{
	alarm[0] = 1
}

for(var i = 0 ; i < 120 ; i++)
{
	array_sprites[i] = new vector2(irandom_range(0,room_width),irandom_range(bbox_top+16 , bbox_bottom-16));
}




draw_mineral = function()
{
	var _num = array_length(array_sprites)
	
	for(var i = 0 ; i < _num ; i++)
	{
		draw_sprite_ext(sprite_index , 1 , array_sprites[i].x,array_sprites[i].y,1 * scale, 1 * scale,image_angle+angle,image_blend , 1);
	}
	
	for(var i = 0 ; i < _num ; i++)
	{
		draw_sprite_ext(sprite_index , 0 , array_sprites[i].x,array_sprites[i].y,1 * scale, 1 * scale,image_angle+angle,image_blend , 1);
	}

	if(white_timer)
	{
		gpu_set_fog(true , c_white , 1,0);
		for(var i = 0 ; i < _num ; i++)
		{
			draw_sprite_ext(sprite_index , 0 , array_sprites[i].x,array_sprites[i].y,1 * scale, 1 * scale,image_angle+angle,image_blend , random(.1));
		}
		gpu_set_fog(false , c_white , 1,0);
	}
}

draw_life = function()
{
	if(life < life_max)
	{
		var _x = lerp(x , obj_player.x,.8);
		
		draw_donut(_x,bbox_top,8,12,32,life/life_max,0,c_yellow,1)
	}
}