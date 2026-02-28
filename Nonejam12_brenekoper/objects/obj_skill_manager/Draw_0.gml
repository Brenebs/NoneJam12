
with(obj_skill) {
	for (var i = 0; i < array_length(linked_to); i++) {
		var _element = linked_to[i];
		
		draw_line_width(x, y, _element.x, _element.y, 2);
	}
}