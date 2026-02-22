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
	
	prompt = false;
	
	hover = false;
	pressed = false;
	prompt_flag = false;
	
	_system_update = fx() {
		
		var _hover = GUI
		
		update();
	}
	
	action = fx() {};
}