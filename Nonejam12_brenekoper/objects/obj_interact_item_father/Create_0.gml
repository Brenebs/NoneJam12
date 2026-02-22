/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

is_hovered = false;

when_interacted = function(_player = obj_player)
{
	show_message("bolinhas!")
}

can_be_interacted = function(_player = obj_player)
{
	return true;
}

draw_object = function()
{
	image_blend = is_hovered ? c_dkgray : c_white;
	
	draw_self();
}