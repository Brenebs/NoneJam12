/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if(pointer && inside_ground && image_alpha > 0)
{
	var _nearest = instance_nearest(x,y,obj_teleport_botton);
	
	var _angle = point_direction(x,y,_nearest.x,_nearest.y)
	var _dist = 16;
	
	var _x = _nearest.x - lengthdir_x(_dist , _angle);
	var _y = _nearest.y - lengthdir_y(_dist , _angle);
	
	var _off = 32;
	_x = clamp(_x , CAMERA_X + _off, CAMERA_X + CAMERA_WIDTH - _off);
	_y = clamp(_y , CAMERA_Y + _off, CAMERA_Y + CAMERA_HEIGHT - _off);
	
	draw_sprite_ext(spr_arrow  , 0 , _x , _y ,1,1 ,_angle,c_white,1);
}