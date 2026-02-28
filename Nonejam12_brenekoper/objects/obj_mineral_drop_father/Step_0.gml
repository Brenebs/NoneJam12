
PauseInstanceHandler();

timer_to_be_collected = max_timer(timer_to_be_collected);



if(follow_player)
{
	var _ins = instance_nearest(x,y,obj_player);
	
	speed = lerp(speed , 7.5 + (player_dash * 2), .1);
	
	direction = point_direction(x,y,_ins.x,_ins.y);
}
else
{
	speed = lerp(speed , 0 , .1);
	
	var _col = collision_circle(x,y,distance_follow,obj_player,false,true);
	
	if(timer_to_be_collected <= 0 && (_col || player_dash))
	{
		follow_player = true;
	}
}


var _mrg = 16;
x = clamp(x,16,room_width-_mrg)