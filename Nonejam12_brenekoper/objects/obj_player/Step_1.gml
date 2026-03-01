/// @description Insert description here
// You can write your code in this editor
if(!visible || image_alpha <=0) exit;

var _nearest = instance_nearest(x,y,obj_teleport_botton);
	_nearest.nearest = lerp(_nearest.nearest,1,.2);