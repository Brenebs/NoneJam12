
//debugs e configurações do projeto
#macro DEBUG_BUILD true
#macro GAME_SPEED 60

#macro GAME_NAME game_display_name
window_set_caption(GAME_NAME);

//save
#macro SAVE_NAME string_lettersdigits(GAME_NAME)+".json"
#macro GAME_INFO global.game_save //os dois são a mesma coisa eu só tenho os dois pq eu as vezes escrevo outro
#macro GAME_SAVE global.game_save //os dois são a mesma coisa eu só tenho os dois pq eu as vezes escrevo outro

//facilitadores de functions
#macro ROOM_WIDTH room_width
#macro ROOM_HEIGHT room_width

#macro GUI_WIDTH display_get_gui_width()
#macro GUI_HEIGHT display_get_gui_height()

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


