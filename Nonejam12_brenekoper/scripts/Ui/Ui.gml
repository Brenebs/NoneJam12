function UiElement(_x, _y, _w, _h, _x_center = _w * .5, _y_center = _h * .5) constructor {
	
	owner = noone;
	
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
		
		draw();
		
		//	Debug
		draw_set_alpha(_alpha);
		draw_rectangle_colour(_x1, _y1, _x2, _y2, debug_color, debug_color, debug_color, debug_color, true);
		draw_set_alpha(1);
	}
}

function UiText(_x, _y, _w, _h, _x_center = _w * .5, _y_center = _h * .5)  : UiElement(_x, _y, _w, _h, _x_center, _y_center) constructor {
	
	//	Parameters
	text = fx() { return "" };
	text_color = #ffffff;
	text_scale = 1;
	text_scribble = false;
	text_halign = fa_center;
	text_valign = fa_middle;
	text_font = fnt_pb;
	
	_system_draw = fx(_xoff = 0, _yoff = 0, _a = 1, _c = #ffffff) {
		
		var _x = x + x_offset + _xoff;
		var _y = y + y_offset + _yoff;
		
		//	Text
		var _txt = text();
	
		draw_set_font(text_font);
		draw_set_halign(text_halign);
		draw_set_valign(text_valign);
		draw_set_alpha(1);
		if text_scribble {
			draw_text_scribble_ext(
				_x - SHADOW_TEXT_OFFSET,
				_y + SHADOW_TEXT_OFFSET,
				$"[scale, {text_scale}][#000000]{_txt}",
				width - SHADOW_TEXT_OFFSET * 2
			);
		}
		else {
			draw_text_ext_transformed_colour(
				_x - SHADOW_TEXT_OFFSET,
				_y + SHADOW_TEXT_OFFSET,
				_txt,
				1,
				width - SHADOW_TEXT_OFFSET * 2,
				text_scale, text_scale,
				0,
				0, 0, 0, 0,
				draw_get_alpha()
			);
		}
		draw_set_alpha(1);
		if text_scribble {
			draw_text_scribble_ext(
				_x,
				_y,
				$"[scale, {text_scale}][{color_to_string(text_color)}]{_txt}",
				width - SHADOW_TEXT_OFFSET * 2
			);
		}
		else {
			draw_text_ext_transformed_colour(
				_x,
				_y,
				_txt,
				1,
				width - SHADOW_TEXT_OFFSET * 2,
				text_scale, text_scale,
				0,
				text_color, text_color, text_color, text_color,
				draw_get_alpha()
			);
		}
		draw_set_font(-1);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	}
}
	
function UiButton(_x, _y, _w, _h, _x_center = _w * .5, _y_center = _h * .5) : UiElement(_x, _y, _w, _h, _x_center, _y_center) constructor {
	
	//	Parameters
	text = fx() { return "" };
	text_color = #ffffff;
	text_scale = 1;
	text_scribble = true;
	text_halign = fa_center;
	text_valign = fa_middle;
	text_font = fnt_pb;
	
	sprite = spr_button;
	color = #db6395;
	
	depth = 6;
	
	prompt = false;
	prompt_text = "Tem certeza?";
	prompt_color = #ff4444;
	
	press_confirm = false;
	
	//	States
	hover = false;
	pushed = false;
	prompt_flag = false;
	
	_system_update = fx(_input = true) {
		navigate(_input);
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
		
		#region Util Variables
			
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
			
			var _button_depth = depth;
			var _button_side_offset = 0;
			
			var _color = color;
			
			if prompt_flag {
				_matrix_x += lengthdir_x(2, current_time * 1.66);
				
				_color = prompt_color;
			}
			
		#endregion
		
		#region	Animation
		
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
			
		#endregion
		
		#region	Shadow
		
			var _new_matrix = matrix_build(
				_matrix_x + SHADOW_OFFSET, _matrix_y + SHADOW_OFFSET, 0,
				0, 0, angle,
				x_scale, y_scale, 1
			);
			matrix_set(matrix_world, _new_matrix);
		
			draw_set_alpha(SHADOW_ALPHA);
			gpu_set_fog(true, 0, 0, 1);
			draw_sprite_stretched(spr_button, 1, _x1, _y1 + _button_depth * push_anim, width, height - _button_depth * push_anim);
			gpu_set_fog(false, 0, 0, 1);
			draw_set_alpha(1);
		
		#endregion
		
		#region	Main Draw
			
			_new_matrix = matrix_build(
				_matrix_x, _matrix_y, 0,
				0, 0, angle,
				x_scale, y_scale, 1
			);
			matrix_set(matrix_world, _new_matrix);
			
			//	Rect
			draw_sprite_stretched_ext(sprite, 1, _x1, _y1 + _button_depth, width, height - _button_depth, _color, _alpha);
			if hover draw_sprite_stretched_ext(sprite, 2, _x1, _y1 + _button_depth, width, height - _button_depth, _color, _alpha * .66);
			
			draw_sprite_stretched_ext(sprite, 0, _x1, _y1 + ((_button_depth - _button_side_offset) * push_anim), width, height - _button_depth, _color, _alpha);
			if hover draw_sprite_stretched_ext(sprite, 2, _x1, _y1 + ((_button_depth - _button_side_offset) * push_anim), width, height - _button_depth, _color, _alpha * .66);
			
			//	Text
			var _txt = text();
			
			if prompt_flag _txt = prompt_text;
			
			draw_set_font(text_font);
			draw_set_halign(text_halign);
			draw_set_valign(text_valign);
			draw_set_alpha(1);
			if text_scribble {
				draw_text_scribble_ext(
					-SHADOW_TEXT_OFFSET,
					SHADOW_TEXT_OFFSET + (_button_depth - _button_side_offset) * push_anim - (_button_depth * .5),
					$"[scale, {text_scale}][#000000]{_txt}",
					width - SHADOW_TEXT_OFFSET * 2
				);
			}
			else {
				draw_text_ext_transformed_colour(
					-SHADOW_TEXT_OFFSET,
					SHADOW_TEXT_OFFSET + (_button_depth - _button_side_offset) * push_anim - (_button_depth * .5) - 2,
					_txt,
					1,
					width - SHADOW_TEXT_OFFSET * 2,
					text_scale, text_scale,
					0,
					0, 0, 0, 0,
					draw_get_alpha()
				);
			}
			draw_set_alpha(1);
			if text_scribble {
				draw_text_scribble_ext(
					0,
					(_button_depth - _button_side_offset) * push_anim - (_button_depth * .5),
					$"[scale, {text_scale}][{color_to_string(text_color)}]{_txt}",
					width - SHADOW_TEXT_OFFSET * 2
				);
			}
			else {
				draw_text_ext_transformed_colour(
					0,
					(_button_depth - _button_side_offset) * push_anim - (_button_depth * .5) - 2,
					_txt,
					1,
					width - SHADOW_TEXT_OFFSET * 2,
					text_scale, text_scale,
					0,
					text_color, text_color, text_color, text_color,
					draw_get_alpha()
				);
			}
			draw_set_font(-1);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			
			draw();
		
		#endregion
		
		//	Debug
		//draw_set_alpha(_alpha);
		//draw_rectangle_colour(_x1, _y1, _x2, _y2, debug_color, debug_color, debug_color, debug_color, !hover);
		//draw_set_alpha(1);
		
		matrix_set(matrix_world, _default_matrix);
	}
	
	navigate = fx(_input) {
		
		//	Setup
		var _x1 = x - x_center + x_offset;
		var _y1 = y - y_center + y_offset;
		
		var _x2 = _x1 + width;
		var _y2 = _y1 + height;
		
		var _hover = point_in_rectangle(MOUSE_GUI_X, MOUSE_GUI_Y, _x1, _y1, _x2, _y2) and _input;
		
		if (_hover and (window_get_cursor() != cr_handpoint)) {
			if WINDOWS_CURSOR window_set_cursor(cr_handpoint);	
		}
		
		if (_hover and mouse_check_button_pressed(mb_left)) {
			press_confirm = true;
			press();
		}
		else if !_hover press_confirm = false;
		
		var _pushed = _hover and mouse_check_button(mb_left) and press_confirm;
		var _released = !_pushed and pushed;
		var _true_released = _hover and mouse_check_button_released(mb_left) and press_confirm;
		
		if (_hover and !hover) awake();
		else if (!_hover and hover) sleep();
		
		if _released release()
		
		if _true_released {
			if (!prompt or prompt_flag) {
				action();
				prompt_flag = false;
			}
			else {
				prompt_flag = true;
			}
			true_release();
		}
		
		pushed = _pushed;
		hover = _hover;
	}
	
	//	Feedback Functions
	awake = fx() {
		x_scale = 1.025;
		y_scale = 1.025;
		
		sfx_play([sfx_ui_awake_1, sfx_ui_awake_2, sfx_ui_awake_3], .5, .1);
		
		angle = choose(-4, 4);
	}
	sleep = fx() {
		if WINDOWS_CURSOR window_set_cursor(cr_default);
		
		prompt_flag = false;
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

//	Enums
enum UI_EVENT {
	EMPTY,
	DESTROY,
	DEACTIVATE
}

//	Macros
#macro WINDOWS_CURSOR true

scribble_font_bake_outline_8dir(font_get_name(fnt_pb), "fnt_pb_o", #000000, false);