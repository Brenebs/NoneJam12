

if(keyboard_check_pressed(vk_escape) && GAMEPLAY_ROOM && can_pause)
{
	pausing_game();	
}


global.wave_pot += !global.pause;