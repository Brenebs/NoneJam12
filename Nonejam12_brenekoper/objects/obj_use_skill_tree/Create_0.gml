/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

event_inherited();

when_interacted = function()
{
	sfx_play([snd_skill_enter1, snd_skill_enter2, snd_skill_enter3, snd_skill_enter4])
	instance_create_depth(0, 0, 0, obj_transition).action = fx() { change_room(rm_skill_tree) };
}
