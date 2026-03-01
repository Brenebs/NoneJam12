/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// Inherit the parent event
event_inherited();

nearest = false;

when_interacted = function(_player = obj_player)
{
	do_boing();
	with(_player)
	{
		state = state_goup;
	}
}