// Inherit the parent event
event_inherited();

image_yscale = (sprite_get_height(sprite) + bt_depth) / sprite_get_height(sprite);

width = sprite_width;
height = sprite_height;

y -= bt_depth * .5;

alarm[0] = 2;

purchased_n = 0;

action = fx() {
	if ((purchased_n <= upgrade_amt) and (get_price() <= GAME_INFO.coins)) {
		UPGRADES[$ upgrade_var] += 1;
	}
	purchased_n++;
	GAME_INFO.coins -= price;
}

get_price = fx() {
	return price + price * (price_mult * purchased_n); 
}

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
		
		var _button_depth = bt_depth;
		var _button_side_offset = 0;
		
		var _can_purchase = (GAME_INFO.coins >= get_price());
		var _purchased = purchased_n >= upgrade_amt;
		
		var _color = color;
		
		if (purchased_n <= 0) _color = #a1a1a1;
		
		if _purchased _color = #88ff88;
		else if !_can_purchase _color = #ff8888;
		
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
		
		var _scissor_w = 5;
		var _scissor = gpu_get_scissor();
		
		draw_sprite_stretched_ext(spr_button_skill, 0, _x1, _y1 + ((_button_depth - _button_side_offset) * push_anim), width, height - _button_depth, _color, _alpha);
		gpu_set_scissor(
			(_matrix_x - x_center) - CAMERA_X + _scissor_w - 1,
			(_matrix_y - y_center) - CAMERA_Y + _scissor_w + ((_button_depth - _button_side_offset) * push_anim),
			width - (_button_depth * .5) - _scissor_w * 2 + 4,
			height - (_button_depth * .5) - _scissor_w * 2 - 2
		);
		draw_sprite_stretched_ext(sprite, 0, _x1, _y1 + ((_button_depth - _button_side_offset) * push_anim), width, height - _button_depth, #ffffff, _alpha);
		gpu_set_scissor(_scissor);
		
		if hover draw_sprite_stretched_ext(sprite, 2, _x1, _y1 + ((_button_depth - _button_side_offset) * push_anim), width, height - _button_depth, _color, _alpha * .66);
		
		draw();
	
	#endregion
	
	matrix_set(matrix_world, _default_matrix);
}