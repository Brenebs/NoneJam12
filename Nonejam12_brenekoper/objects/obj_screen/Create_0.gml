
//	Container
content = [];

push_content = fx() {
	for (var i = 0; i < argument_count; i++) {
		var _element = argument[i];
		array_push(content, _element);
	}
}

update_content = fx() {
	for (var i = 0; i < array_length(content); i++) {
		var _element = content[i];
		
		_element._system_update();
	}
}

draw_content = fx() {
	for (var i = 0; i < array_length(content); i++) {
		var _element = content[i];
		
		_element._system_draw();
	}
}

var _y = GUI_HEIGHT * .1;

var _button_test1 = new UiButton(GUI_WIDTH * .9, _y, 80, 32); _y += 35;
var _button_test2 = new UiButton(GUI_WIDTH * .9, _y, 80, 32); _y += 35;
var _button_test3 = new UiButton(GUI_WIDTH * .9, _y, 80, 32); _y += 35;
var _button_test4 = new UiButton(GUI_WIDTH * .9, _y, 80, 32); _y += 35;
var _button_test5 = new UiButton(GUI_WIDTH * .9, _y, 80, 32); _y += 35;
var _button_test6 = new UiButton(GUI_WIDTH * .9, _y, 80, 32); _y += 35;
var _button_test7 = new UiButton(GUI_WIDTH * .9, _y, 80, 32); _y += 35;
var _button_test8 = new UiButton(GUI_WIDTH * .9, _y, 80, 32); _y += 35;
var _button_test9 = new UiButton(GUI_WIDTH * .9, _y, 80, 32); _y += 35;

_button_test1.text = fx() { return "say gex" };
_button_test2.text = fx() { return "sesbian lex" };
_button_test3.text = fx() { return "pay gorn" };
_button_test4.text = fx() { return "pesbian lorn" };
_button_test5.text = fx() { return "sla" };
_button_test6.text = fx() { return "falange" };
_button_test7.text = fx() { return "abluble" };
_button_test8.text = fx() { return ":D" };
_button_test9.text = fx() { return ">:]" };

push_content(
	_button_test1,
	_button_test2,
	_button_test3,
	_button_test4,
	_button_test5,
	_button_test6,
	_button_test7,
	_button_test8,
	_button_test9,
);