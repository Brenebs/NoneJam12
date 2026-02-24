/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

event_inherited();

when_interacted = function()
{
	if(room == rm_real_world)
	{
		save_game()
		obj_camera.change_world();
		//instance_create_depth(0, 0, 0, obj_transition).action = fx() { change_room(rm_gameplay) };
	}
	else
	{
		save_game()
		obj_camera.change_world();
		//instance_create_depth(0, 0, 0, obj_transition).action = fx() { change_room(rm_real_world) };
	}	
}

can_be_interacted = function(_player = obj_player)
{
	return !_player.inside_ground;
}

/*if(mouse_check_button_pressed(mb_middle))
			{
				if(room == rm_real_world)
				{
					room_goto(rm_gameplay)
				}
				else
				{
					room_goto(rm_real_world)
				}	
				
			}