
//debugs e configurações do projeto
#macro DEBUG_BUILD true
#macro GAME_SPEED 60

#macro GAME_NAME game_display_name
window_set_caption(GAME_NAME);


//save
#macro SAVE_NAME string_lettersdigits(GAME_NAME)+".json"
#macro GAME_INFO global.game_save //os dois são a mesma coisa eu só tenho os dois pq eu as vezes escrevo outro
#macro GAME_SAVE global.game_save //os dois são a mesma coisa eu só tenho os dois pq eu as vezes escrevo outro
#macro UPGRADES global.game_save.upgrades
#macro SKILL_THREE global.game_save.upgrades

//facilitadores de functions
#macro ROOM_WIDTH room_width
#macro ROOM_HEIGHT room_width

#macro GUI_WIDTH display_get_gui_width()
#macro GUI_HEIGHT display_get_gui_height()

#macro MOUSE_GUI_X device_mouse_x_to_gui(0)
#macro MOUSE_GUI_Y device_mouse_y_to_gui(0)

#macro CAMERA_X camera_get_view_x(view_camera[0])
#macro CAMERA_Y camera_get_view_y(view_camera[0])
#macro CAMERA_WIDTH camera_get_view_width(view_camera[0])
#macro CAMERA_HEIGHT camera_get_view_height(view_camera[0])

#macro CAMERA_BASE_WIDTH  1280
#macro CAMERA_BASE_HEIGHT 720

global.camera_zoom = 1
#macro CAMERA_ZOOM global.camera_zoom
global.gameplay_room = false;
#macro GAMEPLAY_ROOM global.gameplay_room


#macro DBG_TYPE_STRING "s"
#macro DBG_TYPE_INT	   "i"
#macro DBG_TYPE_REAL   "r"

#macro LISTENER_FOLLOW_PLAYER true

global.pause = false; 
global.death = false;


#region Scribble

#macro SCRIB_WAVE "[wave]"
#macro SCRIB_WAVE0 "[/wave]"

#macro SCRIB_SHAKE  "[shake]"
#macro SCRIB_SHAKE0 "[/shake]"

#macro SCRIB_WOOBLE  "[wobble]"
#macro SCRIB_WOOBLE0 "[/wobble]"

#macro SCRIB_PULSE  "[pulse]"
#macro SCRIB_PULSE0 "[/pulse]"

#macro SCRIB_WHEEL  "[wheel]"
#macro SCRIB_WHEEL0 "[/wheel]"

#macro SCRIB_JITTER  "[jitter]"
#macro SCRIB_JITTER0 "[/jitter]"

#macro SCRIB_BLINK  "[blink]"
#macro SCRIB_BLINK0 "[/blink]"

#macro SCRIB_RAIBOW  "[rainbow]"
#macro SCRIB_RAIBOW0 "[/rainbow]"

#endregion


#macro CHUNKS_OFFSET 2
#macro CHUNK_HEIGHT (CAMERA_BASE_HEIGHT*.4)
#macro CHUNK_MAX 130

//	Autismo
#macro fx function

global.current_world = 1;
#macro CURRENT_WORLD global.current_world
#macro SHADOW_OFFSET 3
#macro SHADOW_TEXT_OFFSET 1
#macro SHADOW_ALPHA .33