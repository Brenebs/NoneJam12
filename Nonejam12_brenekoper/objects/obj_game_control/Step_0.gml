

if(keyboard_check_pressed(vk_escape) && GAMEPLAY_ROOM && can_pause)
{
	pausing_game();	
}


global.wave_pot += !global.pause;

if audio_is_playing(electric) {
	audio_sound_gain(electric, global.electric_sound, 0);
	show_debug_message(global.electric_sound);
}

global.electric_sound *= .95;