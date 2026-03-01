/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// Inherit the parent event
event_inherited();

evade_teleport_height();

is_enemy = true;

damage = 20;
knockback = 15;

mineral_drop = obj_mineral_drop_5;

area_explosion = 128;

activated = false;

timer_to_explode = GAME_SPEED*2;
current_timer_to_explode = 0;

life_total = life;

get_knockback = function(_ins)
{
	return point_direction(x,y,_ins.x,_ins.y);
}

exploding = function()
{
	
	var _ins = collision_circle(x,y,area_explosion,obj_player,true , true);
	
	if(_ins)
	{
		if(_ins.can_i_be_hurt(id))
		{
			_ins.current_energy-=damage*_ins.defensive_multipliyer;
			_ins.current_timer_invincible = _ins.timer_invincible;
			
			var _direction = get_knockback(_ins);
			
			_ins.state = _ins.state_hurt;
			_ins.timer_stunned = 20;
			_ins.acel_after_attack = 0;
			
			_ins.hspd = lengthdir_x(knockback , _direction);
			_ins.vspd = lengthdir_y(knockback , _direction);
		}
	}
	
	instance_destroy();
}

//if(_ins)
//{
//	if(_ins.can_i_be_hurt(id))
//	{
//		_ins.current_energy-=damage*_ins.defensive_multipliyer;
//		_ins.current_timer_invincible = _ins.timer_invincible;
			
//		var _direction = get_knockback();
			
//		_ins.state = _ins.state_hurt;
//		_ins.timer_stunned = 10;
//		_ins.acel_after_attack = 0;
			
//		_ins.hspd = lengthdir_x(knockback , _direction);
//		_ins.vspd = lengthdir_y(knockback , _direction);
//	}
//}
