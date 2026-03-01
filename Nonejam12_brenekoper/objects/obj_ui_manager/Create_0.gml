
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
	overworld= "";
}

draw_inputs = fx() {
	
}