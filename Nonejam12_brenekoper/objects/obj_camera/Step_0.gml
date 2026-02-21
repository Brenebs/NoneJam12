/// @description Insert description here
// You can write your code in this editor

if(global.pause) return;

if(instance_exists(alvo))
{
	camera_second_acel = lerp(camera_second_acel,(point_distance(x,y,alvo.x,alvo.y) > distance_to_follow),.01)
	
	x=lerp(x,alvo.x + offset.x,acel * camera_second_acel);
	y=lerp(y,alvo.y + offset.y,acel * camera_second_acel);
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


var _y = max(y - (CAMERA_HEIGHT/2) , 0);
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

audio_listener_set_position(0, _x, _y, 0);

if(check_camera())
{
	update_camera(camera_zoom_acel)
}