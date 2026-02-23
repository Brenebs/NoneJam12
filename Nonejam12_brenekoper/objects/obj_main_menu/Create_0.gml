event_inherited();

side_length = 96;

draw_background = fx() {
	draw_set_alpha(bg_alpha);
	draw_rectangle_colour(0, 0, (GUI_WIDTH * .18) * anim, GUI_HEIGHT, bg_color, bg_color, bg_color, bg_color, false);
	draw_set_alpha(1);
}

draw_content = fx() {
	for (var i = 0; i < array_length(content); i++) {
		var _element = content[i];
		
		_element._system_draw((side_length * -2) + (side_length * 2) * anim);
	}
}

var _x = side_length;
var _y = GUI_HEIGHT * .4;

var _w = 100;
var _h = 32;

var _y_offset = _h * 1.33;

var _play_button = new UiButton(_x, _y, _w, _h);
with(_play_button) {
	text = fx() { return "Jogar" };
	action = fx() {
		room_goto(rm_gameplay);
	}
}

_y += _y_offset;

var _credits_button = new UiButton(_x, _y, _w, _h);
with(_credits_button) {
	text = fx() { return "Créditos" };
}

_y += _y_offset;


var _options_button = new UiButton(_x, _y, _w, _h);
with(_options_button) {
	text = fx() { return "Opções" };
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