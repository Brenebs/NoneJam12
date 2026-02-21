
event_inherited();

angle_direction = 0;
shoot_speed = 0;

drill = instance_create_depth(x,y,depth,obj_drill_hitbox)

#region mineirando

	inside_ground = true;

	damage = 1;
	dash_damage_multiply = 1.5;
	
	current_timer_offset_attacks = 0;
	timer_offset_attacks		 = 7;
	dash_timer_offset_attacks	 = 4;
	
	push_force_when_attack		= .75;
	push_force_when_attack_dash = 2;
	
	speed_multiply_timer = .05;
	current_speed_multiply = 0
	
	acel_after_attack = 1;
	
	check_entity_to_drill = function(_damage_multiply = 1 , _timer_betwen_hits = timer_offset_attacks , oposite_speed = push_force_when_attack)
	{
		if(current_timer_offset_attacks>0) return;
		
		var _list = ds_list_create();	
		var push_once = true;
		
		var _num = 0;
		with(drill)
		{
			_num = instance_place_list(x,y,[obj_mineral_father],_list,true);
		}
		
		for(var i = 0 ; i < _num ; i++)
		{
			var _current = ds_list_find_value(_list , i);
			
			_current.scale=1.5;
			_current.life -= damage * _damage_multiply;
			_current.white_timer = clamp(timer_offset_attacks-1 , 0 ,5);
			current_energy -= (_current.resistency * damage_energy_cost_multiply) * _damage_multiply;
			
			if(_current.life<=0)
			{
				_current.destroy_function();
			}
			else
			if(push_once)
			{
				push_once = false;
	
				hspd = lengthdir_x(-oposite_speed * .5,angle_direction);
				vspd = lengthdir_y(-oposite_speed * .5,angle_direction);
				
				acel_after_attack = 0;
				
				x += lengthdir_x(-oposite_speed ,angle_direction);
				y += lengthdir_y(-oposite_speed ,angle_direction);
				
				current_timer_offset_attacks = _timer_betwen_hits
				speed_multiply_timer = current_timer_offset_attacks+1;
				current_dash_timer -= current_timer_offset_attacks*.5
			}
		}
		ds_list_destroy(_list);
	}
	
	

#endregion

#region erergia
	
	energy_max = 150;
	current_energy = energy_max;
	
	still_energy_cost		= .02;
	move_energy_cost		= 0.4;
	dash_bust_energy_cost	= 5;
	
	damage_energy_cost_multiply = 2;
	state_dash_energy_cost = .1;

#endregion

#region dash

	speed_walking=4;
	current_speed=speed_walking;
	aceleration = .10;
	
	//dash
	//tempo pro dash terminar de carregar e realmente iniciar
	dash_load_timer = GAME_SPEED;
	current_dash_load_timer = 0
	
	//a distancia entre o ponto inicial e o final
	dash_distance_max = 200;
	
	//tempo na duraçãodo dash
	dash_flow_timer = GAME_SPEED*.3
	current_dash_timer = 0;
	dash_speed = 0;

#endregion

#region se desenhando 


	draw_entity = function()
	{
		
		if(number_is_between(angle_direction,1,180-1))
		{
			draw_drill();
			draw_player();
		}
		else
		{
			draw_player();
			draw_drill();
		}
	}
	
	draw_player = function()
	{
		draw_sprite_ext(sprite_index,image_index,x,y,xscale * look_at , yscale , image_angle + angle , image_blend , 1);
	}
	
	draw_drill = function()
	{
		if(!can_cave) 
		{
			draw_sprite_ext(spr_litou_hat,0,x,y - 10 - wave(1,-1,2) , xscale * look_at , yscale , 0 , image_blend , 1);
			return;
		}
		
		var _dist = 8
		var _x = lengthdir_x(_dist , angle_direction);
		var _y = lengthdir_y(_dist*.8 , angle_direction);
		
		draw_sprite_ext(spr_drill_base,0,x + _x ,y + _y , xscale , yscale , 0 , image_blend , 1);
	
		_dist = 6
		_x += lengthdir_x(_dist , angle_direction);
		_y += lengthdir_y(_dist , angle_direction);
			
		drill.x = x + _x;
		drill.y = y + _y;
		drill.image_angle = angle_direction;
		draw_sprite_ext(spr_drill	 ,0,x + _x ,y + _y , xscale , yscale , angle_direction , image_blend , 1);
	}
	
	draw_gui = function()
	{
		draw_healthbar(20,20,100 + energy_max,30,current_energy/energy_max * 100 , c_black , c_red , c_white , 0,true , true);
	}
	
	draw_border = function(){}
	draw_reload_feedback = function(){}

#endregion

#region state machine debaixo da terra

	//andando debaixo da terra
	state_walk = function()
	{
		image_blend = c_white
		
	
		var _direction = point_direction(x,y,mouse_x,mouse_y);
		var _spd = mouse_check_button(mb_left) && (point_distance(x,y,mouse_x,mouse_y) > 16);
		
		var _hspd = lengthdir_x(1,_direction)
		var _vspd = lengthdir_y(1,_direction)
	
		h_spd	= _hspd * current_speed * _spd;
		hspd	= lerp(hspd , h_spd , aceleration * acel_after_attack);
	
		v_spd	= _vspd * current_speed * _spd;
		vspd	= lerp(vspd , v_spd , aceleration * acel_after_attack)
	
		var _point = _direction;
		if(_spd || (abs(hspd) + abs(vspd))>1)
		{
			check_entity_to_drill();
		}
	
		angle_direction = lerp_angle(angle_direction,_point , .1)
		angle_direction = wrap(angle_direction,0,359.9);
	
		if(number_is_between(angle_direction,90,270)) look_at = -1
		else look_at = 1;
		
		
		
		if(mouse_check_button(mb_right))
		{
			state = state_dash_load;
			
			current_dash_timer = 0;
			current_dash_load_timer = 0
		}
	}
	
	//carregando dash
	state_dash_load = function()
	{
		image_blend = c_orange;
		
		hspd	= lerp(hspd , 0 , aceleration);
		vspd	= lerp(vspd , 0 , aceleration)
		
		var _direction = point_direction(x,y,mouse_x,mouse_y);
	
		angle_direction = lerp_angle(angle_direction,_direction , .5)
		angle_direction = wrap(angle_direction,0,359.9);
	
		if(number_is_between(angle_direction,90,270)) look_at = -1
		else look_at = 1;
		
		
		current_dash_load_timer = clamp(current_dash_load_timer+1,0,dash_load_timer)
		
		if(!mouse_check_button(mb_right))
		{
			state = state_dash_released;
			current_dash_timer = 0;
			
			var _x = lengthdir_x(dash_distance_max ,angle_direction)
			var _y = lengthdir_y(dash_distance_max ,angle_direction)
			var _dist = point_distance(x,y,x+_x,y+_y) / dash_flow_timer;
			
			dash_speed = _dist;
			
			hspd = lengthdir_x(dash_speed,angle_direction);
			vspd = lengthdir_y(dash_speed,angle_direction);
			
			current_energy -= dash_bust_energy_cost;
		}
	}
	
	//indo pra frente
	state_dash_released = function()
	{
		
		current_energy -= state_dash_energy_cost;
		
		image_blend = c_red;
		
		var _hspd = lengthdir_x(dash_speed,angle_direction);
		var _vspd = lengthdir_y(dash_speed,angle_direction);
		
		hspd = lerp(hspd ,_hspd,.3 * acel_after_attack)
		vspd = lerp(vspd ,_vspd,.3 * acel_after_attack)
		
		current_dash_timer++;
		if(current_dash_timer >= dash_flow_timer)
		{
			state = state_walk;
		}
		
		check_entity_to_drill(dash_damage_multiply,dash_timer_offset_attacks,push_force_when_attack_dash);
	}

	state = state_walk;

#endregion

#region state machine acima da terra

	gravity_force = .6;
	max_y_outside = 32
	on_ground = false;
	outside_speed = 5;
	jump_force = 5;
	
	check_horizontal_movement = function()
	{
		return( keyboard_check(ord("D")) - keyboard_check(ord("A")))
	}
	check_confirm = function()
	{
		return keyboard_check_pressed(vk_space);
	}

	state_outside = function()
	{
		on_ground = instance_place(x,y+1,obj_collision);
	
		var _hspd = outside_speed * check_horizontal_movement();
	
		hspd = lerp(hspd , _hspd , .1);
	
		if(!on_ground)
		{
			vspd += gravity_force;
		}
	
	
	
		var _direction = point_direction(x,y,mouse_x,mouse_y);
		var _spd = mouse_check_button(mb_left);
		
		var _point = _direction;
	
		angle_direction = lerp_angle(angle_direction,_point , .1)
		angle_direction = wrap(angle_direction,0,359.9);
	
		if(sign(_hspd) != 0) 
		{
			look_at = sign(_hspd);
		}
		
		
		if(on_ground)
		{
			if(mouse_check_button_pressed(mb_middle))
			{
				if(room == rm_real_world)
				{
					room_goto(rm_gameplay)
				}
				else
				{
					room_goto(rm_real_world)
				}	
				
			}
			
			if(can_cave && number_is_between(angle_direction,180+1,360-1) && mouse_check_button_pressed(mb_left))
			{
				state = state_walk;
				y = -max_y_outside+1
				vspd = 8;
				inside_ground = true;
			}
			else
			if(check_confirm())
			{
				vspd = -8;
			}
		}
	}

	if(y<=-max_y_outside || !can_cave)
	{
		inside_ground = false;
		state = state_outside;
	}

#endregion

max_y = (CHUNK_MAX * CHUNK_HEIGHT) + CHUNK_HEIGHT;
collision=function()
{
	var _multiply = speed_multiply_timer > 0 ? current_speed_multiply : 1
	
	var __x = hspd * _multiply
	var __y = vspd * _multiply
	
	var _movement = (abs(__x) + abs(__y))/50 * move_energy_cost
	current_energy -= max(_movement , still_energy_cost);
	current_energy = wrap(current_energy , 0 , energy_max);
	
	if(!inside_ground)
	{
		for(var i = 0 ; i < floor(abs(__x)) ; i++)
		{
			if(!instance_place(x+sign(__x),y,obj_collision))
			{
				x += sign(__x);
			}
		}
		
		for(var i = 0 ; i < floor(abs(__y)) ; i++)
		{
			if(!instance_place(x,y+sign(__y),obj_collision))
			{
				y += sign(__y);
			}
		}
	}
	else
	{
		x += __x;
		y += __y;
	}
	
	
	
	var _offset = 0
	x = clamp(x , _offset , room_width - _offset);
	y = min(y , max_y);
	
	if(inside_ground) && y < -max_y_outside
	{
		inside_ground = false;
		vspd = -8;
		state = state_outside;
	}
}
