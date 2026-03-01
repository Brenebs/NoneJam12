
var _y = obj_camera.y;

for(var i = bioms_len-1 ; i >= 0 ; i--)
{
	
	if(_y > bioms[i , 1])
	{
		var _alp = 1 - ((_y - bioms[i , 1]) / bioms_transition_offset);
		bioms[i , 2] = lerp(bioms[i , 2],_alp , .5);
	}
	else
	{
		bioms[i , 2] = 1;
	}
	
	var _alpha = bioms[i , 2];
	
	draw_sprite_tiled_ext(bioms[i,0],0,0,-6,1,1,c_white,_alpha);
	
}

var _color =  colors[0];

for(var i = 1 ; i < min(color_len , bioms_len) ; i++)
{
	//show_debug_message($"cake = {i} - {_y} > {bioms[i , 1]}");
	
	if(_y > bioms[i-1 , 1])
	{	
		var _merge = clamp(bioms[i-1 , 2],0,1);
		//show_debug_message($"cake = {i} - {_y} > {_merge}")
		_color = merge_colour(colors[i],colors[i-1],_merge)
	}
}
if(global.color_effect != _color)
{
	global.color_effect = _color

	_color = merge_colour(_color , color_dark , .35)
	
	global.color_effect_bg = _color;

	var _r = colour_get_red(	_color ) / 255;
	var _g = colour_get_green(	_color ) / 255;
	var _b = colour_get_blue(	_color ) / 255;
	
	show_debug_message($"{_r}-{_g}_{_b}")

	fx_set_parameter(fx_merge, "g_OutlineColour", [_r, _g, _b, 1]);
	fx_set_parameter(fx_merge, "g_OutlineRadius", 3);
	fx_set_parameter(fx_merge, "g_OutlinePixelScale", 2);
	//layer_set_fx("GroundEffect",fx_merge);
}