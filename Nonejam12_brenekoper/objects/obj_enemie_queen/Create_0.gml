/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// Inherit the parent event
event_inherited();

evade_teleport_height();

look_at = choose(1,-1);

is_enemy = true;

mineral_drop = obj_mineral_drop_2;



area_to_see_player = 110;
area_to_forget_player = 200;

minions_max = 3;

timer_betwen_attacks = GAME_SPEED*.3;
timer_to_create_minions = GAME_SPEED*2;
current_timer_to_create_minions = 0
current_timer_to_attack = 0;

array_minions = [];
angle_attack = 0;
angle_speed_idle = 2
angle_speed_alert = 3

state_idle = function()
{
	create_minions();
	angle_attack += angle_speed_idle;
	
	image_blend = c_white;
	
	if(distance_to_object(obj_player) < area_to_see_player)
	{
		state = state_alert;
	}
}

state_alert = function()
{
	image_blend = c_red;
	
	create_minions();
	angle_attack += angle_speed_alert;
	
	
	if(array_length(array_minions)>0)
	{
		current_timer_to_attack++;
		if(current_timer_to_attack >= timer_betwen_attacks)
		{
			//var _ins = array_shift(array_minions);
			var _ins = array_pop(array_minions);
			_ins.state = _ins.state_flow;
			_ins.direction_goto = point_direction(_ins.x,_ins.y,obj_player.x,obj_player.y);
			
			current_timer_to_attack = 0;
			
		}
	}
	
	if(distance_to_object(obj_player) > area_to_forget_player)
	{
		state = state_idle;
	}
}

create_minions = function()
{
	if(array_length(array_minions) < minions_max)
	{
		current_timer_to_create_minions++;
		if(current_timer_to_create_minions>=timer_to_create_minions)
		{
			var _ins = instance_create_depth(x,y,depth+1,obj_enemie_minion_follower);
			_ins.scale = 0;
			array_push(array_minions,_ins);
			current_timer_to_create_minions = 0;
		}
	}
	
	var _num = array_length(array_minions)
	for(var i = 0 ; i < _num ; i++)
	{
		var _angle = (i/minions_max * 360) + angle_attack;
		
		var _x = lengthdir_x(40 , _angle);
		var _y = lengthdir_y(40 , _angle);
		
		array_minions[i].x = x + _x;
		array_minions[i].y = y + _y;
		
		array_minions[i].image_angle = _angle + 90
		array_minions[i].image_angle = _angle + 90
	}
}

state = state_idle
