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
}

if(global.pause) return;

inventory_handler();

current_timer_offset_attacks = max_timer(current_timer_offset_attacks);
speed_multiply_timer		 = max_timer(speed_multiply_timer);
acel_after_attack = lerp(acel_after_attack , 1 , .1);

