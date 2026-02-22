
//	Container
content = [];

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