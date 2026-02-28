/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// Inherit the parent event
event_inherited();

is_enemy = true;

look_at = choose(1,-1);
walk_direction = point_direction(0,0,look_at,0);

mineral_drop = obj_mineral_drop_2;

hspd = 0;
vspd = 0;
walk_speed = 2;

damage = 5;
knockback = 10;

hitbox = instance_create_depth(x,y,depth-1,obj_hitbox_hurt_player);
hitbox.owner = id;
hitbox.image_yscale = 1.2;

get_knockback = function()
{
	return walk_direction;
}

state_idle = function()
{
	var _mrg = 32
	if(x < _mrg)
	{
		look_at = 1;
	}
	
	if(x > room_width - _mrg)
	{
		look_at = -1;
	}
	
	var _direction = point_direction(0,0,look_at,0);
	walk_direction = lerp_angle(walk_direction , _direction , .05);
	
	hspd = lengthdir_x(walk_speed , walk_direction);
	vspd = lengthdir_y(walk_speed , walk_direction);
	
	image_angle = walk_direction;
}

state = state_idle

collision = function()
{
	x+=hspd;
	y+=vspd;
	
	hitbox.x = x + lengthdir_x(16 , walk_direction);
	hitbox.y = y + lengthdir_y(16 , walk_direction);
	hitbox.image_angle = walk_direction;
	
	var _ins;
	
	with(hitbox)
	{
		_ins = instance_place(x,y,obj_drill_hitbox);
		
		if(_ins)
		{
			_ins = _ins.owner;
		}
		else
		{
			_ins = instance_place(x,y,obj_player);
		}
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