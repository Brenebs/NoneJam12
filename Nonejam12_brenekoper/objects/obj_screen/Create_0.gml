
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

draw_content = fx() {
	for (var i = 0; i < array_length(content); i++) {
		var _element = content[i];
		
		_element._system_draw();
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

//	States
active = false;
locked = false;

//	Animation
anim = 0;
anim_target = 1;
anim_acc = .125;

draw_background = fx() {
	draw_set_alpha(bg_alpha);
	draw_rectangle_colour(0, 0, GUI_WIDTH, GUI_HEIGHT, bg_color, bg_color, bg_color, bg_color, false);
	draw_set_alpha(1);
}

draw_screen = fx() {
	draw_background();
	draw_content();
}