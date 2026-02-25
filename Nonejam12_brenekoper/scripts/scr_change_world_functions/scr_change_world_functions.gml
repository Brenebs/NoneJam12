// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações


function camera_change_world()
{
	camera_zoom = .25;
	camera_zoom_acel = .1;
	
	obj_game_control.can_pause = false;
	
	with(obj_player)
	{
		state = state_prepare_fall;
		//state_falling
	}
	
	var _temp = 1.1;
	call_later(_temp,time_source_units_seconds,function()
	{
		CURRENT_WORLD = !CURRENT_WORLD;
		
		with(obj_player)
		{
			state = state_falling;
			obj_player.can_cave = (!CURRENT_WORLD)
		}
	})
	
	_temp += .3
	call_later(_temp,time_source_units_seconds,function()
	{
		camera_zoom = .5;
		camera_zoom_acel = .05;
	})
	
	_temp += .5
	call_later(_temp,time_source_units_seconds,function()
	{
		camera_zoom_acel = .1;
	})
	
	_temp += .5
	call_later(_temp,time_source_units_seconds,function()
	{
		update_camera(1);
		camera_angle = CURRENT_WORLD * 180;
	}) 
}

function update_game_mid_jump()
{
	// indo pro mundo real
	if(CURRENT_WORLD)
	{
		reset_everything();	
	}
	else
	//indo pro mundo doce
	{
		generate_world();
		//deactivate_instances();	
	}
	
}