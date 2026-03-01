update_all_purchases = fx() {
	
	with(obj_skill) {
		purchase_update();
	}
	
}

draw_topbar = function() {
	var _border = 6;
	
	draw_sprite_stretched_ext(spr_bar, 0, _border - 2, _border + 2, GUI_WIDTH - _border * 2, 36, #000000, 1);
	draw_sprite_stretched_ext(spr_bar, 0, _border, _border, GUI_WIDTH - _border * 2, 36, #db6395, 1);
}

draw_bar = fx() {
	draw_topbar();
	
	var _scrib = scribble($"[fnt_pb_o] ${string_format_nlarge(GAME_INFO.coins)}");
	
	var _x = 28;
	var _y = 26;
	
	_scrib
		.align(fa_left, fa_middle)
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
	
	draw_sprite_ext(spr_money_icon, 0, _x - 1, _y + 1, 1, 1, 0, #000000, 1);
	draw_sprite_ext(spr_money_icon, 0, _x, _y, 1, 1, 0, #ffffff, 1);
}