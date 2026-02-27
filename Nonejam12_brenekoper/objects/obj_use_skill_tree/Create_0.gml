/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

event_inherited();

when_interacted = function()
{
	instance_create_depth(0, 0, 0, obj_transition).action = fx() { change_room(rm_skill_tree) };
}
