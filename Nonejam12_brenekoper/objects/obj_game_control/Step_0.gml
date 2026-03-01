

if(keyboard_check_pressed(vk_escape) && GAMEPLAY_ROOM && can_pause && !instance_exists(obj_choose_level))
{
	pausing_game();	
}


global.wave_pot += !global.pause;

if audio_is_playing(electric) {
	audio_sound_gain(electric, global.electric_sound, 0);
}

global.electric_sound *= .95;