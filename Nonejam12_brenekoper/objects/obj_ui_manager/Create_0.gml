
screens = [];

screens_list_clear = fx() {
	screens = [];
}

add_screen = fx(_screen) {
	array_push(screens, _screen);
	
	array_sort(screens, fx(_e1, _e2) {
	    return _e1.priority - _e1.priority;
	})
}

remove_screen = fx(_screen) {
	for (var i = 0; i < array_length(screens); i++) {
		var _element = screens[i];
		
		if (_element == _screen) {
			array_delete(screens, i, 1);
			i--;
		}
	}
}

check_priority = fx(_priority) {
	var _highest = array_first(screens);
	
	if instance_exists(_highest) {
		return _priority >= _highest.priority;
	}
	else {
		return true;
	}
}

inputs = {};
with(inputs) {
	menu = fx() { return "Interagir [spr_mouse_left]" };
	overworld = fx() { return "Interagir [spr_space]" };
	skill_tree = fx() { return "Comprar [spr_mouse_left]\nMover [spr_mouse_right]\nSair [spr_esc]" };
	expedition = fx() { return $"Cavar [spr_mouse_left]{UPGRADES.dash_unlocked ? "\nMover [spr_mouse_right]" : ""}" };
}

current_input = "menu";

draw_inputs = fx() {
	var _scrib = scribble($"[fnt_pb_o]{inputs[$ current_input]()}");
	
	var _padding = 12;
	
	var _x = GUI_WIDTH - _padding;
	var _y = GUI_HEIGHT - _padding;
	
	_scrib
		.align(fa_right, fa_bottom)
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