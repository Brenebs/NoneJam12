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

sound = -1;

get_knockback = function(_ins)
{
	return point_direction(x,y,_ins.x,_ins.y);
}

exploding = function()
{
	
	audio_stop_sound(sound);
	sfx_play(snd_explosion);
	
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

draw_mineral = function()
{
	
	draw_sprite_ext(sprite_index , image_index , x,y,image_xscale * scale, image_yscale * scale,image_angle+angle,image_blend , 1);

	if(white_timer)
	{
		gpu_set_fog(true , c_white , 1,0);
		
		draw_sprite_ext(sprite_index , 0 , x,y,image_xscale * scale, image_yscale * scale,image_angle+angle,image_blend , .5);
	
		gpu_set_fog(false , c_white , 1,0);
	}
}

enemy_clone_mineral()

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
