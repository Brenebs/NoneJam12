// Inherit the parent event
event_inherited();

region_w = 360;
region_h = 180;
region_alpha = .8;

anim = -1;
anim_target = 0;
anim_acc = .25;

close = fx() {
	anim_event = UI_EVENT.DESTROY;
	locked = true;
	anim_target = 1;
	anim_flag = false;
}

draw_region = fx(_xoff = 0, _yoff = 0) {
	var _x = GUI_WIDTH * .5;
	var _y = GUI_HEIGHT * .5;
	
	draw_set_alpha(region_alpha);
	draw_sprite_stretched(
		spr_modal_bg,
		0,
		_xoff + _x - region_w * .5,
		_yoff + _y - region_h * .5,
		region_w,
		region_h
	);
	draw_set_alpha(1);
}

draw_screen = fx(_x = 0, _y = 0) {
	draw_background(0, 0, 1 - abs(anim));
	draw_region(_x, _y)
	draw_content(_x, _y);
}