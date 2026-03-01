
polygons = [];

Polygon = fx(_color = #ffffff, _delay = 0, _out = false, _kill_when_end = true) constructor {
	color = _color;
	
	out = _out;
	
	delay_clock = _delay;
	anim = 0;
	anim_acc = .3;
	
	kill_when_end = _kill_when_end;
	
	radius = 1280;
	
	update = fx() {
		delay_clock -= (delay_clock > 0);
		if (delay_clock <= 0) {
			anim = lerp(anim, 1, anim_acc);
		}
		
		return ((anim >= 1) and kill_when_end);
	}
	
	draw = fx() {
		draw_primitive_begin(pr_trianglelist);
		
		var _center_x = 0;
		var _center_y = GUI_HEIGHT;
		
		var _start_angle = 180;
		var _end_angle = _start_angle - 90;
		
		var _angle_direction = 1;
		
		//	Out
		if out {
			_center_x = GUI_WIDTH;
			_center_y = GUI_HEIGHT;
			
			_start_angle = 180;
			_end_angle = _start_angle - 90;
		}
		
		//	Ldir
		var _angle_1 = _start_angle - 90 * _angle_direction * anim;
		var _angle_2 = _end_angle - 90 * _angle_direction * anim;
		
		if (!out or (anim > 0)) {
			draw_vertex_colour(_center_x + lengthdir_x(radius, _angle_1), _center_y + lengthdir_y(radius, _angle_1), color, 1);
			draw_vertex_colour(_center_x, _center_y, color, 1);
			draw_vertex_colour(_center_x + lengthdir_x(radius, _angle_2), _center_y + lengthdir_y(radius, _angle_2), color, 1);
			draw_primitive_end();
		}
	}
}

array_push(polygons, new Polygon(#fff09a, (00 + 00), false));
array_push(polygons, new Polygon(#ff886d, (18 + 00), false));
array_push(polygons, new Polygon(#ff93b9, (22 + 00), false));
array_push(polygons, new Polygon(#000000, (25 + 00), false));

array_push(polygons, new Polygon(#b95fff, (25 + 39), true));
array_push(polygons, new Polygon(#93e8ff, (22 + 39), true));
array_push(polygons, new Polygon(#9affbb, (18 + 39), true));
array_push(polygons, new Polygon(#000000, (00 + 39), true));

action = fx() {};

acted = false;
__system_action = fx() {
	acted = true;
	action();
}