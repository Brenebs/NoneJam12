if locked exit;

if(hover)
{
	var _color_in = $"[{color_to_string(get_color())}]";
	var _color_out = "[#ffffff]";
	
	if (purchased_n >= upgrade_amt) {
		_color_in = "[rainbow]";
		_color_out = "[/rainbow]";
	}
	
	var _scrib = scribble($"[fnt_pb_o]{_color_in}{display_name}{_color_out}\n[fnt_p]{description}{ (purchased_n < upgrade_amt) ? $"\n[spr_money_icon][fnt_pb] {_color_in}${string_format_nlarge(get_price())}{_color_out}" : "" }");
	
	_scrib.align(fa_center, fa_middle);
	_scrib.wrap(240);
	
	var _w = _scrib.get_width();
	var _h = _scrib.get_height();
	
	var _padding = 8;
	
	var _offset = ((_w + sprite_width * 1.5) * .5 + _padding) * (((MOUSE_GUI_X + _w + _padding * 2) > GUI_WIDTH) ? -1 : 1);
	
	var _x = x - CAMERA_X + _offset;
	var _y = y - CAMERA_Y;
	
	draw_sprite_stretched_ext(
		spr_modal_bg,
		0,
		_x - _padding - _w * .5,
		_y - _padding - _h * .5,
		_w + _padding * 2,
		_h + _padding * 2,
		#ffffff,
		.9
	)
	
	_scrib
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