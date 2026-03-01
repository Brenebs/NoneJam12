if locked exit;

_system_draw();

if(purchased_n > 0 && upgrade_amt>1)
{
	var _color_in = $"[{color_to_string(merge_color(get_color(), #ffffff, .66))}]";
	
	var _scrib = scribble($"[fnt_pb_o]{_color_in}{min(purchased_n, upgrade_amt)}/{upgrade_amt}");
	
	var _x = x + 1 + lengthdir_x(sprite_height * .5,angle - 90);
	var _y = y + 1 + lengthdir_y(sprite_height * .5,angle - 90);
	
	_scrib
		.transform(1, 1, angle)
	
	_scrib
		.align(fa_middle, fa_center)
		.flash(#000000, 1)
		.draw(
			_x - 1,
			_y + 1
		)

	_scrib
		.flash(#ffffff, 0)
		.draw(
			_x,
			_y
		)
}