/// @description Insert description here
// You can write your code in this editor
//	Main listener needs to follow the camera
audio_listener_position(x, y, 0);

if(global.pause) return;

var _player_outside = false;


camera_angle = lerp_angle(camera_angle,(CURRENT_WORLD && room == rm_gameplay) * 180);
camera_angle = wrap(camera_angle,0,359.99)
//camera_angle = 0;
camera_set_view_angle(view_camera[0],camera_angle);

if(instance_exists(alvo))
{
	camera_second_acel = lerp(camera_second_acel,(point_distance(x,y,alvo.x,alvo.y) > distance_to_follow),.01)
	
	
	
	var __y = alvo.y + offset.y
	var __x = alvo.x + offset.x;
	
	if(alvo.y<0)
	{
		__y = min(-200 * CAMERA_ZOOM,__y);
		
		with(obj_player)
		{
			if(state != state_prepare_fall)
			{
				__y = max(__y , global.camera_min_y);
			}
		}
	}
	else
	{
		if(alvo.image_alpha>0)
		{
			var _len = min( point_distance( __x , __y , mouse_x , mouse_y) *.125 , 120) ;
			var _dir =		point_direction(__x , __y , mouse_x , mouse_y);
			__y += lengthdir_y(_len*1.1	, _dir) + (alvo.v_spd * 7) //mean(__y , __y , mouse_y);
			__x += lengthdir_x(_len		, _dir) + (alvo.h_spd * 7) //mean(__x , __x , mouse_x);
		}
		__y = max(__y , (CAMERA_HEIGHT/2) - 100)
		
	}
	x=lerp(x,__x,acel * camera_second_acel);
	y=lerp(y,__y,acel * camera_second_acel);
}
else {
	if bool(collision_point(mouse_x, mouse_y, obj_skill, false, true)) and mouse_check_button_pressed(mb_left) {
		cursor_left_lock = true;
	}
	
	if (cursor_left_lock and mouse_check_button_released(mb_left)) {
		cursor_left_lock = false;
	}
	
	var _mouse_press = mouse_check_button_pressed(mb_right) or (mouse_check_button_pressed(mb_left) and !cursor_left_lock) or keyboard_check_pressed(vk_space) or mouse_check_button_pressed(mb_middle)
	var _mouse_hold = mouse_check_button(mb_right) or (mouse_check_button(mb_left) and !cursor_left_lock) or keyboard_check(vk_space) or mouse_check_button(mb_middle)
	
	if _mouse_press {
		cursor_x = MOUSE_GUI_X;
		cursor_y = MOUSE_GUI_Y;
		
		cursor_camera_x = x;
		cursor_camera_y = y;
	}
	
	if _mouse_hold {
		cursor_diff_x = cursor_x - MOUSE_GUI_X;
		cursor_diff_y = cursor_y - MOUSE_GUI_Y;
		
		x = clamp(cursor_camera_x + cursor_diff_x, (CAMERA_WIDTH * .5), room_width - (CAMERA_WIDTH * .5));
		y = clamp(cursor_camera_y + cursor_diff_y, (CAMERA_HEIGHT * .5), room_height - (CAMERA_HEIGHT * .5));
	}
}

if(DEBUG_BUILD)
{
	if(keyboard_check_pressed(vk_f1))
	{
		if(dbg_view_exists(my_debugger) || is_debug_overlay_open())
		{
			debug_destroy()
		}
		else
		{
			debug_create()
		}
	}
}


var _y = y - (CAMERA_HEIGHT/2)
var _x = (x - (CAMERA_WIDTH/2))

if(lock_camera_x)
{
	_x = clamp(x - (CAMERA_WIDTH/2) , 0 , room_width - CAMERA_WIDTH)
}
if(lock_camera_y)
{
	_y = clamp(y - (CAMERA_HEIGHT/2) , 0 , room_height - CAMERA_HEIGHT);
}

camera_set_view_pos(view_camera[0] , _x  , _y );

var _x = 0;
var _y = 0;

if(LISTENER_FOLLOW_PLAYER)
{
	var _p = get_nearest_player(x,y)
	
	if(_p && instance_exists(_p))
	{
		_x = _p.x
		_y = _p.y - 16
	}
}
else
{
	_x = CAMERA_X + (CAMERA_WIDTH/2)
	_y = CAMERA_Y + (CAMERA_HEIGHT/2)
}

audio_listener_set_position(0, round(_x), round(_y), 0);

if(check_camera())
{
	update_camera(camera_zoom_acel)
}