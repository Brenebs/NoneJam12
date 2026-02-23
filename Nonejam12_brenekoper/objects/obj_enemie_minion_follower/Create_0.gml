/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// Inherit the parent event
event_inherited();

look_at = choose(1,-1);
walk_direction = point_direction(0,0,look_at,0);

mineral_drop = obj_mineral_drop_2;

hspd = 0;
vspd = 0;
walk_speed = 2;

damage = 5;
knockback = 10;

timer_to_attack = 20;

get_knockback = function()
{
	return walk_direction;
}

state_idle = function()
{
	//var _mrg = 32
	//if(x < _mrg)
	//{
	//	look_at = 1;
	//}
	
	//if(x > room_width - _mrg)
	//{
	//	look_at = -1;
	//}
	
	//var _direction = point_direction(0,0,look_at,0);
	//walk_direction = lerp_angle(walk_direction , _direction , .05);
	
	//hspd = lengthdir_x(walk_speed , walk_direction);
	//vspd = lengthdir_y(walk_speed , walk_direction);
	
	//image_angle = walk_direction;
	
	walk_direction = image_angle;
}

direction_goto = 270;

state_flow = function()
{
	
	var _mrg = 32;
	
	if(y < CAMERA_Y - _mrg || y > CAMERA_Y + CAMERA_HEIGHT + _mrg || x < -_mrg || x > room_width+_mrg)
	{
		instance_destroy();
	}
	
	walk_direction = lerp_angle(walk_direction , direction_goto , .05);
	
	if(abs(angle_difference(direction_goto,walk_direction)) < 1 )
	{
		hspd = lengthdir_x(walk_speed , walk_direction);
		vspd = lengthdir_y(walk_speed , walk_direction);
	}
	
	image_angle = walk_direction;
}

state = state_idle

collision = function()
{
	x+=hspd;
	y+=vspd;
	
	//hitbox.x = x + lengthdir_x(16 , walk_direction);
	//hitbox.y = y + lengthdir_y(16 , walk_direction);
	//hitbox.image_angle = walk_direction;
	
	if(timer_to_attack>0)
	{
		resistency = 100
		return;
	}
	
	if(((abs(hspd) + abs(vspd)) > .1) ) return;
						  
	var _ins;
	_ins = instance_place(x,y,obj_drill_hitbox);
		
	if(_ins)
	{
		_ins = _ins.owner;
	}
	else
	{
		_ins = instance_place(x,y,obj_player);
	}
	
	
	if(_ins)
	{
		if(_ins.can_i_be_hurt(id))
		{
			_ins.current_energy-=damage*_ins.defensive_multipliyer;
			_ins.current_timer_invincible = _ins.timer_invincible;
			
			var _direction = get_knockback();
			
			_ins.state = _ins.state_hurt;
			_ins.timer_stunned = 10;
			_ins.acel_after_attack = 0;
			
			_ins.hspd = lengthdir_x(knockback , _direction);
			_ins.vspd = lengthdir_y(knockback , _direction);
		}
	}
}