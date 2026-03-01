/// @description Insert description here
// You can write your code in this editor

audio_listener_orientation(0, 0, 1000,0,-1,0);

cursor_left_lock = false;

cursor_x = 0;
cursor_y = 0;

cursor_diff_x = 0;
cursor_diff_y = 0;

cursor_camera_x = 0;
cursor_camera_y = 0;

//sla tava apitando que tava indefinido e parou quando eu coloquei isso kkkkkk
camera_zoom_acel *= 1;
camera_zoom		 *= 1;

offset = new vector2();

camera_second_acel = 3;




camera_angle = 0;

if(CURRENT_WORLD && room == rm_gameplay)
{
	camera_angle = 180;
	camera_set_view_angle(view_camera[0],camera_angle);
}


#region update camera functions

	update_camera = function(_lerp = 1)
	{
		//show_debug_message("Atualizando CAMERA");
		//show_debug_message($"(({CAMERA_BASE_WIDTH} * {camera_zoom}) != {CAMERA_WIDTH})")
		
		var _old = CAMERA_ZOOM;
		CAMERA_ZOOM = lerp(CAMERA_ZOOM , camera_zoom , _lerp)
		camera_set_view_size(view_camera[0],CAMERA_BASE_WIDTH * CAMERA_ZOOM , CAMERA_BASE_HEIGHT * CAMERA_ZOOM);
		//surface_resize(application_surface, CAMERA_WIDTH, CAMERA_HEIGHT)
		
		var _dif = CAMERA_ZOOM - _old;
		camera_set_view_pos(view_camera[0],CAMERA_X - _dif,CAMERA_Y - _dif)
	}

	check_camera = function()
	{
		var _wid = ((CAMERA_BASE_WIDTH * camera_zoom) != CAMERA_WIDTH);
		var _hei = ((CAMERA_BASE_HEIGHT * camera_zoom) != CAMERA_HEIGHT);
		
		return (CAMERA_ZOOM != camera_zoom)
	}
	
#endregion

my_debugger = noone;

change_world = function()
{
	camera_change_world();	
}

debug_create = function()
{
	my_debugger = dbg_view("CAMERA OPTIONS",true)

	dbg_text("Coisas de Câmera");

	var _ref = ref_create(self , "camera_zoom")

	dbg_slider(_ref , 0 , 3,"ZOOM: ",0.1)
	
	var _ref = ref_create(self , "camera_angle")
	dbg_slider(_ref , 0 , 360,"Angle: ",5)
	
	dbg_button("Troca mundo" , change_world)
	
}

debug_destroy = function()
{
	if(dbg_view_exists(my_debugger))
	{
		dbg_view_delete(my_debugger);
	}
	
	show_debug_overlay(false);
}

alarm[0] = true;


