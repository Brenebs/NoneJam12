
//	Container
content = [];

push_content = fx(_content) {
	array_push(content, _content);
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



push_content(new UiButton(GUI_WIDTH * .5, GUI_HEIGHT * .5, 196, 64));