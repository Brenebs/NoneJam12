/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if(keyboard_check_pressed(vk_shift) || keyboard_check_pressed(vk_escape))
{
	instance_create_depth(0, 0, 0, obj_transition).action = fx() { change_room(rm_gameplay) };
	save_game();
}