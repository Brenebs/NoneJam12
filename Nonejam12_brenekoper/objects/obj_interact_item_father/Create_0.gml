/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

is_hovered = false;

xscale = 1;
yscale = 1;

xscale_force = 0;
yscale_force = 0;

never_interact = function()
{
	var _name = object_get_name(object_index);
	
	return !array_contains(GAME_INFO.itens_interact,_name)
	
}

check_arrow = function()
{
	return true;
}

draw_arrow_pointer = function()
{
	if(!check_arrow()) return;
	
	var _frc = !CURRENT_WORLD ? 1 : -1;
	var _x = x 
	var _y = y - (64 + abs(wave(4,-2 , 1.75))) * _frc
	
	var _angle = point_direction(x,_y,x,y);
	
	draw_sprite_ext(spr_arrow,0,x,_y,1,1,_angle,c_white,1);
}

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