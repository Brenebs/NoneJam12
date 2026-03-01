// Inherit the parent event

if (global.pause) {
	if !audio_is_paused(dirt_sound) audio_pause_sound(dirt_sound);
	if !audio_is_paused(drill_sound) audio_pause_sound(drill_sound);
}
else {
	if audio_is_paused(dirt_sound) audio_resume_sound(dirt_sound);
	if audio_is_paused(drill_sound) audio_resume_sound(drill_sound);
}

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
	var _saved = false;
	//if(UPGRADES.ext_life_saver > 0)
	{
		var _ins = collision_circle(x,y,LIFE_SAVER_AREA,[obj_teleport_botton,obj_teleport_top],false,false)
		if(_ins)
		{
			x = lerp(x,_ins.x,.1);
			y = lerp(y,_ins.y,.1);
			if(current_timer_death >= max_timer_death && place_meeting(x,y,_ins))
			{
				_ins.when_interacted(id)
			}
			_saved = true;
		}
	}
	
	current_timer_death++;
	if(!_saved && current_timer_death >= max_timer_death)
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

drill_shakey = random(.5) * (state == state_dash_load);

if inside_ground {
	audio_sound_gain(drill_sound, .25 * !using_elevator, 200);
	drill_pitch = lerp(drill_pitch, (1 + point_distance(x, y, x + hspd, y + vspd) / 8) * !using_elevator, .2);
	drill_fake_doppler = (abs(hspd) + vspd) * .1;
	
	audio_sound_gain(dirt_sound, (1 * !using_elevator) * (point_distance(x, y, x + hspd, y + vspd) > 2), 300);
}
else {
	audio_sound_gain(drill_sound, 0, 500);
	drill_pitch = lerp(drill_pitch, 0, .2);
	
	audio_sound_gain(dirt_sound, 0, 200);
}

audio_sound_pitch(drill_sound, drill_pitch + drill_fake_doppler - drill_shakey);