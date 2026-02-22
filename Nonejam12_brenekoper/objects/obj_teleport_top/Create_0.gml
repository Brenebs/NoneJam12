/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// Inherit the parent event
event_inherited();


when_interacted = function(_player = obj_player)
{
	with(_player)
	{
		state = state_select;
	}
}

can_be_interacted = function(_player = obj_player)
{
	return !_player.inside_ground;
}