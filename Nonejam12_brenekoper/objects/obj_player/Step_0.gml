// Inherit the parent event
event_inherited();


if(DEBUG_BUILD)
{
	if(keyboard_check_pressed(vk_f2))
	{
		if(dbg_view_exists(my_debugger) || is_debug_overlay_open())
		{
			debug_destroy()
		}
		else
		{
			debug_create()
		}
	}
	
	if(DEBUG_BUILD && keyboard_check(vk_add))
	{
		var _frc = !CURRENT_WORLD ? 1 : -1;
		
		if(!on_ground)
		{
			vspd -= 10 * _frc;
		}
	}
	
	if(keyboard_check_pressed(vk_f12))
	{
		save_game()
	}
	if(keyboard_check_pressed(vk_f11))
	{
		load_game()
	}
}

if(global.pause) return;

inventory_handler();

if(number_is_between(current_energy , 0 , percent_show_danger) && inside_ground)
{
	if(!danger_energy)
	{
		
	}
	danger_energy = true;	
}
else
{
	danger_energy = false;
}

if(current_energy <= 0)
{
	current_timer_death++;
	if(current_timer_death >= max_timer_death)
	{
		trigger_death()
	}
}
else
{
	current_timer_death = 0;
}

if(CURRENT_WORLD) current_drill_image_speed = 0;

var _frc = drill_image_speed > current_drill_image_speed ? .01 : .1;
drill_image_speed = lerp(drill_image_speed,current_drill_image_speed,_frc);

drill_image_index += drill_image_speed*.3;
drill_image_index = drill_image_index % sprite_get_number(drill_sprites[drill.image_index])

current_timer_offset_attacks = max_timer(current_timer_offset_attacks);
drill_white_timer			 = max_timer(drill_white_timer);
speed_multiply_timer		 = max_timer(speed_multiply_timer);
current_timer_invincible	 = max_timer(current_timer_invincible);
acel_after_attack			 = lerp(acel_after_attack , 1 , .1);

