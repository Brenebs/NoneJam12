/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// Inherit the parent event
event_inherited();


when_interacted = function(_player = obj_player)
{
	do_boing();
	
	//with(_player)
	//{
	//	state = state_select;
	//}
	if(instance_exists(obj_choose_level))
	{
		obj_choose_level.confirm_button.action()
	}
	else
	{
		instance_create_depth(0, 0, 0, obj_choose_level);
	}
	
}

can_be_interacted = function(_player = obj_player)
{
	return !_player.inside_ground && ((GAME_INFO.max_chunk_achiev div 10) > 0) ;
}