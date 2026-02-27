
PauseInstanceHandler();

timer_to_be_collected = max_timer(timer_to_be_collected);

speed = lerp(speed , 0 , .1);

if(follow_player)
{
	var _ins = instance_nearest(x,y,obj_player);
	
	speed = lerp(speed , 10, .1);
	
	direction = point_direction(x,y,_ins.x,_ins.y);
}
else
if(timer_to_be_collected <= 0 && distance_to_object(obj_player) < distance_follow)
{
	follow_player = true;
}


var _mrg = 16;
x = clamp(x,16,room_width-_mrg)