event_inherited();

side_length = 96;

bg_w = GUI_WIDTH * .18;

draw_background = fx(_x = 0, _y = 0, _alpha = 1) {
	draw_set_alpha(bg_alpha * _alpha);
	draw_rectangle_colour(_x, _y, _x + (GUI_WIDTH * .18) * anim, _y + GUI_HEIGHT, bg_color, bg_color, bg_color, bg_color, false);
	draw_set_alpha(1);
}

draw_content = fx(_x = 0, _y = 0) {
	for (var i = 0; i < array_length(content); i++) {
		var _element = content[i];
		
		_element._system_draw(_x + (side_length * -2) + (side_length * 2) * anim, _y);
	}
}

var _x = side_length;
var _y = GUI_HEIGHT * .4;

var _w = 100;
var _h = 32;

var _y_offset = _h * 1.25;

var _play_button = new UiButton(_x, _y, _w, _h);
with(_play_button) {
	text = fx() { return "Jogar" };
	action = fx() {
		//instance_create_depth(0, 0, 0, obj_transition).action = fx() { change_room(rm_skill_tree) };
		instance_create_depth(0, 0, 0, obj_transition).action = fx() { change_room(rm_gameplay) };
	}
}
_y += _y_offset;

var _credits_button = new UiButton(_x, _y, _w, _h);
with(_credits_button) {
	text = fx() { return "Créditos" };
	action = fx() {
		instance_create_depth(0, 0, 0, obj_credits);
	}
}
_y += _y_offset;

var _options_button = new UiButton(_x, _y, _w, _h);
with(_options_button) {
	text = fx() { return "Opções" };
	action = fx() {
		instance_create_depth(0, 0, 0, obj_options);
	}
}
_y += _y_offset;

var _exit_button = new UiButton(_x, _y, _w, _h);
with(_exit_button) {
	text = fx() { return "Sair" };
	prompt = true;
	action = fx() {
		game_end();
	}
}

push_content(_play_button, _credits_button, _options_button, _exit_button);