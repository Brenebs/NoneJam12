
polygons = [];

Polygon = fx(_color = #ffffff, _delay = 0, _out = false, _kill_when_end = false) constructor {
	color = _color;
	
	out = _out;
	
	delay_clock = _delay;
	anim = 0;
	anim_acc = .2;
	
	kill_when_end = _kill_when_end;
	
	radius = 1280;
	
	update = fx() {
		delay_clock -= (delay_clock > 0);
		if (delay_clock <= 0) {
			anim = lerp(anim, 1, anim_acc);
		}
		
		return ((anim <= 0.005) and kill_when_end);
	}
	
	draw = fx() {
		draw_primitive_begin(pr_trianglelist);
		draw_vertex_colour(lengthdir_x(radius, -180 + 90 * anim), lengthdir_y(radius, -90 + 90 * anim) + GUI_HEIGHT, color, 1);
		draw_vertex_colour(0, GUI_HEIGHT, color, 1);
		draw_vertex_colour(lengthdir_x(radius, -90 + 90 * anim), lengthdir_y(radius, -90 + 90 * anim) + GUI_HEIGHT, color, 1);
		draw_primitive_end();
	}
}

array_push(polygons, new Polygon());

action = fx() {};

__system_action = fx() {
	action();
}