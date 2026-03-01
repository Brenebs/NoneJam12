/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

is_hovered = false;

xscale = 1;
yscale = 1;

xscale_force = 0;
yscale_force = 0;

do_boing = function()
{
	xscale = 1.25;
	yscale = 0.75;
}

when_interacted = function(_player = obj_player)
{
	do_boing();
	if(y < 0)
	{
		with(_player)
		{
			state = state_select;
		}
	}
	else
	{
		with(_player)
		{
			state = state_goup;
		}
	}
}

can_be_interacted = function(_player = obj_player)
{
	return true;
}

draw_object = function()
{
	image_blend = is_hovered ? c_dkgray : c_white;
	
	draw_sprite_ext(sprite_index , image_index , x , y , image_xscale * xscale , image_yscale * yscale , image_angle , image_blend , image_alpha);
}