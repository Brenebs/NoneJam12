function UiElement(_x, _y, _w, _h, _x_center = _w * .5, _y_center = _h * .5) constructor {
	
	//	Transform
	width = _w;
	height = _h;
	
	x = _x;
	y = _y;
	
	x_center = _x_center;
	y_center = _y_center;
	
	x_offset = 0;
	y_offset = 0;
	
	x_scale = 1;
	y_scale = 1;
	
	angle = 0;
	
	//	Blend
	debug_color = make_colour_hsv(irandom(255), 255, 255);
	color = #ffffff;
	
	alpha = 1;
	
	matrix_mode = false;
	
	update = fx() {};
	draw = fx() {};
	
	_system_update = fx() {
		update();
	}
	
	_system_draw = fx(_xoff = 0, _yoff = 0, _a = 1) {
		
		//	Setup
		var _x1 = x - x_center + x_offset + _xoff;
		var _y1 = y - y_center + y_offset + _yoff;
		
		var _x2 = _x1 + width;
		var _y2 = _y1 + height;
		
		var _alpha = alpha * _a;
		
		#region Matrix
		//var _default_matrix = matrix_get(matrix_world);
		
		//var _matrix_x = x - x_center * x_scale;
		//var _matrix_y = y - y_center * y_scale;
		
		//var _new_matrix = matrix_build(
		//	_matrix_x, _matrix_y, 0,
		//	0, 0, angle,
		//	x_scale, y_scale, 1
		//);
		
		////	Start Drawing
		//matrix_set(matrix_world, _new_matrix);
		
		////	Do Stuff
		
		//matrix_set(matrix_world, _default_matrix);
		#endregion
		
		draw();
		
		//	Debug
		draw_set_alpha(_alpha);
		draw_rectangle_colour(_x1, _y1, _x2, _y2, debug_color, debug_color, debug_color, debug_color, true);
		draw_set_alpha(1);
	}
}
	
function UiButton(_x, _y, _w, _h, _x_center = _w * .5, _y_center = _h * .5) : UiElement(_x, _y, _w, _h, _x_center, _y_center) constructor {
	
	//	Parameters
	text = "";
	depth = 12;
	
	prompt = false;
	
	press_confirm = false;
	
	hover = false;
	pushed = false;
	prompt_flag = false;
	
	_system_update = fx() {
		navigate();
		update();
	}
	
	push_anim = 0;
	push_anim_spd = 0;
	
	x_scale_spd = 0;
	y_scale_spd = 0;
	x_scale_target = 1;
	y_scale_target = 1;
	
	angle_spd = 0;
	
	_system_draw = fx(_xoff = 0, _yoff = 0, _a = 1, _c = #ffffff) {
		
		//	Setup
		var _x = x + x_offset + _xoff;
		var _y = y + y_offset + _yoff;
		
		var _x1 = -x_center;
		var _y1 = -y_center;
		
		var _x2 = _x1 + width;
		var _y2 = _y1 + height;
		
		var _alpha = alpha * _a;
		
		var _default_matrix = matrix_get(matrix_world);
		
		var _matrix_x = _x;
		var _matrix_y = _y;
		
		var _new_matrix = matrix_build(
			_matrix_x, _matrix_y, 0,
			0, 0, angle,
			x_scale, y_scale, 1
		);
		
		//	Animation
		if !pushed {
			push_anim_spd = lerp(push_anim_spd, -push_anim * 1.5, .2);
			push_anim += push_anim_spd;
			
			x_scale_target = 1;
			y_scale_target = 1;
		}
		else {
			push_anim = 1;
			
			x_scale = .975;
			y_scale = .975;
			x_scale_target = x_scale;
			y_scale_target = y_scale;
		}
		
		x_scale_spd = lerp(x_scale_spd, (x_scale_target - x_scale) * .7, .2);
		y_scale_spd = lerp(y_scale_spd, (y_scale_target - y_scale) * .6, .3);
		x_scale += x_scale_spd;
		y_scale += y_scale_spd;
		
		angle_spd = lerp(angle_spd, -angle * 1.2, .3);
		angle += angle_spd;
		
		//	Start Drawing
		matrix_set(matrix_world, _new_matrix);
		
		var _button_depth = depth;
		var _button_side_offset = 3;
		
		draw_sprite_stretched(spr_button, 1, _x1, _y1 + _button_depth, width, height - _button_depth);
		if hover {
			draw_set_alpha(_alpha * .5);
			draw_sprite_stretched(spr_button, 2, _x1, _y1 + _button_depth, width, height - _button_depth);
			draw_set_alpha(1);
		}
		draw_sprite_stretched(spr_button, 0, _x1, _y1 + ((_button_depth - _button_side_offset) * push_anim), width, height - _button_depth);
		if hover {
			draw_set_alpha(_alpha * .5);
			draw_sprite_stretched(spr_button, 2, _x1, _y1 + ((_button_depth - _button_side_offset) * push_anim), width, height - _button_depth);
			draw_set_alpha(1);
		}
		
		draw();
		
		//	Debug
		//draw_set_alpha(_alpha);
		//draw_rectangle_colour(_x1, _y1, _x2, _y2, debug_color, debug_color, debug_color, debug_color, !hover);
		//draw_set_alpha(1);
		
		matrix_set(matrix_world, _default_matrix);
	}
	
	navigate = fx() {
		
		//	Setup
		var _x1 = x - x_center + x_offset;
		var _y1 = y - y_center + y_offset;
		
		var _x2 = _x1 + width;
		var _y2 = _y1 + height;
		
		var _hover = point_in_rectangle(MOUSE_GUI_X, MOUSE_GUI_Y, _x1, _y1, _x2, _y2);
		
		if (_hover and mouse_check_button_pressed(mb_left)) {
			press_confirm = true;
			press();
		}
		else if !_hover press_confirm = false;
		
		var _pushed = _hover and mouse_check_button(mb_left) and press_confirm;
		var _released = !_pushed and pushed;
		var _true_released = _hover and mouse_check_button_released(mb_left);
		
		if (_hover and !hover) awake();
		else if (!_hover and hover) sleep();
		
		if _released release()
		
		if _true_released {
			action();
			true_release();
		}
		
		pushed = _pushed;
		hover = _hover;
	}
	
	awake = fx() {
		x_scale = 1.025;
		y_scale = 1.025;
		
		sfx_play([sfx_ui_awake_1, sfx_ui_awake_2, sfx_ui_awake_3], .5, .1);
		
		angle = choose(-4, 4);
	}
	
	sleep = fx() {
		
	}
	
	press = fx() {
		sfx_play(sfx_ui_press);
	}
	
	release = fx() {
		sfx_play(sfx_ui_release);
	}
	
	true_release = fx() {
		x_scale = 1.05;
		y_scale = 1.05;
	}
	
	action = fx() {};
}