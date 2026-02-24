
obj_ui_manager.add_screen(id);

//	Container
content = [];

push_content = fx() {
	for (var i = 0; i < argument_count; i++) {
		var _element = argument[i];
		
		_element.owner = id;
		
		array_push(content, _element);
	}
}

update_content = fx(_input) {
	for (var i = 0; i < array_length(content); i++) {
		var _element = content[i];
		
		_element._system_update(_input);
	}
}

draw_content = fx(_x = 0, _y = 0, _a = 1) {
	for (var i = 0; i < array_length(content); i++) {
		var _element = content[i];
		
		_element._system_draw(_x, _y, _a);
	}
}

close = fx() {
	anim_event = UI_EVENT.DESTROY;
	locked = true;
	anim_target = 0;
	anim_flag = false;
}

anim_event = UI_EVENT.EMPTY;
anim_flag = false;

anim_event_update = fx() {
	if !anim_flag {
		
		switch(anim_event) {
			case UI_EVENT.DEACTIVATE: {
				
				active = false;
				
			} break;
			
			case UI_EVENT.DESTROY: {
				
				instance_destroy();
				
			} break;
		}
		
		anim_flag = true;
	}
}

//	Atributes
bg_alpha = .5;
bg_color = #000000;
bg_w = GUI_WIDTH;
bg_h = GUI_HEIGHT;

//	States
active = false;
locked = false;

//	Animation
anim = 0;
anim_target = 1;
anim_acc = .125;

draw_background = fx(_x = 0, _y = 0, _alpha = 1) {
	draw_set_alpha(bg_alpha * _alpha);
	draw_rectangle_colour(_x, _y, _x + bg_w, _y + bg_h, bg_color, bg_color, bg_color, bg_color, false);
	draw_set_alpha(1);
}

draw_screen = fx(_x = 0, _y = 0) {
	draw_background(_x, _y);
	draw_content(_x, _y);
}