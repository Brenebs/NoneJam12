//draw_self()


var _distx = mouse_x - CAMERA_X;
var _disty = mouse_y - CAMERA_Y;

draw_rectangle(CAMERA_X , CAMERA_Y,mouse_x,mouse_y,true);

draw_text(CAMERA_X , CAMERA_Y + 160,$"x = {_distx} / {_disty}")