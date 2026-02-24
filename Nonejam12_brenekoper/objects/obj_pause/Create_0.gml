
global.pause = true;

event_inherited();

content = [];

var _x = side_length;
var _y = GUI_HEIGHT * .4;

var _w = 100;
var _h = 32;

var _y_offset = _h * 1.25;

var _resume_button = new UiButton(_x, _y, _w, _h);
with(_resume_button) {
	text = fx() { return "Retomar" };
	action = fx() {
		owner.close();
	}
}
push_content(_resume_button);
_y += _y_offset;

//tem q alterar pq n troca mais de sala
if (CURRENT_WORLD) {
	var _give_up_button = new UiButton(_x, _y, _w, _h);
	with(_give_up_button) {
		text = fx() { return "Desistir" };
		prompt = true;
		action = fx() {
			instance_create_depth(0, 0, 0, obj_transition).action = fx() { change_room(rm_real_world) };
		}
	}
	push_content(_give_up_button);
	_y += _y_offset;
}

var _options_button = new UiButton(_x, _y, _w, _h);
with(_options_button) {
	text = fx() { return "Opções" };
	action = fx() {
		instance_create_depth(0, 0, 0, obj_options);
	}
}
push_content(_options_button);
_y += _y_offset;

var _menu_button = new UiButton(_x, _y, _w, _h);
with(_menu_button) {
	text = fx() { return "Menu Principal" };
	prompt = true;
	action = fx() {
		instance_create_depth(0, 0, 0, obj_transition).action = fx() { change_room(rm_main_menu) };
	}
}
push_content(_menu_button);
_y += _y_offset;

var _exit_button = new UiButton(_x, _y, _w, _h);
with(_exit_button) {
	text = fx() { return "Sair" };
	prompt = true;
	action = fx() {
		game_end();
	}
}
push_content(_exit_button);