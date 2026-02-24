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

current_timer_offset_attacks = max_timer(current_timer_offset_attacks);
drill_white_timer			 = max_timer(drill_white_timer);
speed_multiply_timer		 = max_timer(speed_multiply_timer);
current_timer_invincible	 = max_timer(current_timer_invincible);
acel_after_attack			 = lerp(acel_after_attack , 1 , .1);

