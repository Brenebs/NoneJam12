
event_inherited();

angle_direction = 0;
shoot_speed = 0;

drill = instance_create_depth(x,y,depth,obj_drill_hitbox)
drill.owner = id;

drill_sprites = [spr_drill_appearence_1 , spr_drill_appearence_2 , spr_drill_appearence_3, spr_drill_appearence_4];
drill_image_index = 0;
drill_image_speed = 0;
current_drill_image_speed = 0;

drill_sound = sfx_play(snd_drill_loop, 0, 0, true);
drill_pitch = 0;
drill_fake_doppler = 0;
drill_shakey = 0;

using_elevator = false;

dirt_sound = sfx_play(snd_dirt_loop, 0, 0, true);

#region mineirando

	inside_ground = true;
	
	drill_level = 2;

	damage = 1;
	damage_level = 0;
	dash_damage_multiply = 1.5;
	critical_dash_damage_multiply = 1.2;
	
	current_timer_offset_attacks = 0;
	timer_offset_attacks		 = 7;
	dash_timer_offset_attacks	 = 4;
	
	push_force_when_attack		= .75;
	push_force_when_attack_dash = 2;
	
	speed_multiply_timer = .05;
	current_speed_multiply = 0
	
	acel_after_attack = 1;
	
	drill_white_timer = 0;
	
	max_vspd = 15;
	
	have_drill = true;
	
	check_entity_to_drill = function(_damage_multiply = 1 , _timer_betwen_hits = timer_offset_attacks , oposite_speed = push_force_when_attack)
	{
		if(current_timer_offset_attacks>0 || current_timer_invincible > 0) return;
		
		var _dash = state == state_dash_released;
		
		var _list = ds_list_create();	
		var push_once = true;
		
		var _num = 0;
		with(drill)
		{
			var _scl = 1
			if(instance_place(x,y,obj_mineral_father))
			{
				var _xscale	= image_xscale
				var _yscale	= image_yscale
				
				_scl = 1.03 + ( image_index * .1 ) + (.25*_dash);
				
				image_xscale *= _scl;
				image_yscale *= _scl; 
				
				sfx_play([snd_ore_damage1, snd_ore_damage2, snd_ore_damage3]);
			}
			
			_num = instance_place_list(x,y,[obj_mineral_father],_list,true);
			
			image_xscale = _scl;
			image_yscale = _scl; 
		}
		
		for(var i = 0 ; i < _num ; i++)
		{
			var _current = ds_list_find_value(_list , i);
			
			_current.scale=1.25;
			_current.angle=random_range(5,-5);
			
			var _mult = min(_damage_multiply,_current.life)
			
			
			var _can_attack = drill_level >= _current.resistency;
			consume_energy((!_can_attack*.5) + (damage_energy_cost_multiply) * _mult);
			if(_can_attack)
			{
				
				if(_num > 0 && eletric_drill>0)
				{
					var _area = eletric_drill+20;
					with(_current)
					{
						if(collision_circle(x,y,_area,obj_mineral_father,false,true))
						{
							var _ins = instance_create_depth(x,y,depth,obj_ray_player);
								ds_list_add(_ins.list_damaged,id);
								
								_ins.ray = _area;
								_ins.damage = (other.damage * _damage_multiply) / 6 * UPGRADES.drill_eletric  ;
								_ins.check_next_instance();
						}
					}
				}
				
				_current.white_timer = clamp(timer_offset_attacks-1 , 0 ,5);
				_current.life -= damage * _damage_multiply;
			}
			else
			{
				drill_white_timer = clamp(timer_offset_attacks-3 , 0 ,5);
				oposite_speed*=1.2
			}
		
			
			if(_current.life<=0)
			{
				var _is_dash = false
				if(dash_colector && _dash)
				{
					_is_dash = true
				}
				_current.destroy_function(_is_dash);
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
	
	percent_show_danger			 = 150 *.25;
	danger_energy				 = false;
	danger_energy_scale			 = 0;
	danger_energy_scale_spring   = 0;
	
	max_timer_death = GAME_SPEED*1.5;
	current_timer_death = 0;
	player_dead = false;
	
	still_energy_cost		= .02;
	move_energy_cost		= 0.4;
	dash_bust_energy_cost	= 5;
	life_steal_percent		= 0;
	
	damage_energy_cost_multiply = 2;
	state_dash_energy_cost = .1;
	

	timer_stunned = 0;
	defensive_multipliyer = 2;
	timer_invincible = GAME_SPEED*.8;
	current_timer_invincible = 0
	

#endregion

#region dash

	//movimentação
	speed_walking = 4;
	base_speed    = speed_walking;
	current_speed = speed_walking;
	aceleration   = .10;
	
	//dash
	has_dash = false;
	
	dash_colector = false;
	
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
		if(image_alpha <=0) return;
		
		var _difference = -10;
		
		var _back = number_is_between(angle_direction,_difference,180-_difference);
		if(CURRENT_WORLD)
		{
			_back = !_back;
		}
			
		if(_back)
		{
			draw_drill();
			draw_player();
		}
		else
		{
			draw_player();
			draw_drill();
		}
		
		if(state == state_dash_load)
		{
			//progress_hollow_circle(x - 32 , y - 32,current_dash_load_timer+2,dash_load_timer,5 , 8, 32)
			draw_donut(x - 32 , y - 32, 5, 8, 14, current_dash_load_timer / dash_load_timer);
		}
		
		draw_option_on_elevator();
	}
	
	draw_head_inground = function(_alp)
	{
		if(player_dead) return;
		var _sep = (360 / 8);
		var _ind = ( (angle_direction + (_sep/2)) div _sep)
		draw_sprite_ext(spr_player_cake_head,_ind,x,y - 12,xscale , yscale , image_angle + angle , image_blend , image_alpha * _alp);
	}
	
	draw_body_inground = function(_alp)
	{
		draw_sprite_ext(sprite_index,image_index,x,y,xscale * look_at , yscale , image_angle + angle , image_blend , image_alpha * _alp);
	}
	
	draw_player_normal = function(_alp)
	{
		if(!CURRENT_WORLD)
		{
			draw_sprite_ext(sprite_index,image_index,x,bbox_bottom,xscale * look_at , yscale , image_angle + angle , image_blend , image_alpha * _alp);
		}
		else
		{
			draw_sprite_ext(sprite_index,image_index,x,bbox_top,xscale * look_at , yscale , image_angle + angle + 180 , image_blend , image_alpha * _alp);
		}
		
		if(can_cave || !have_drill) return;
		draw_sprite_ext(spr_litou_hat,0,x,bbox_bottom + wave(1,4,2) , xscale * look_at , yscale , angle + 180 , image_blend , 1);
	}
	
	draw_player = function()
	{
		
		
		
		if(inside_ground)
		{
			var _alp = current_timer_invincible > 0 ? wave(.5,.8,3) : 1;
			var _offset = 30;
			if(!number_is_between(angle_direction,90 - _offset,90 + _offset))
			{
				draw_body_inground(_alp);
				draw_head_inground(_alp);
			}
			else
			{
				draw_head_inground(_alp);
				draw_body_inground(_alp);
			}
		}
		else
		{
			draw_player_normal(1);
		}
		
		danger_energy_scale_spring = spring_lerp(danger_energy_scale,danger_energy_scale_spring,danger_energy,.3,.2);
		danger_energy_scale += danger_energy_scale_spring;
	
		if(danger_energy_scale > 0)
		{
			draw_sprite_ext(spr_battery_player,0,x + 32,y - 32,danger_energy_scale,danger_energy_scale,0,c_white,.2 + (danger_energy_scale*.5));
		}
		
		if(sprite_index == spr_player_normal_falling)
		{
			var _distance = 20;
			var _angle = angle + 90;
			if(CURRENT_WORLD) _angle += 180
			var _x = x + lengthdir_x(_distance , _angle);
			var _y = y + lengthdir_y(_distance , _angle);
			draw_sprite_ext(drill_sprites[drill.image_index],drill_image_index,_x,_y,1,1,_angle,c_white,1);
		}
	}
	
	draw_drill = function()
	{
		if(!can_cave || !have_drill) 
		{
			return;
		}
		
		
		if(drill_white_timer>0) gpu_set_fog(true , c_dkgray , 1,0);
		
		var _dist = 8
		var _x = lengthdir_x(_dist , angle_direction);
		var _y = lengthdir_y(_dist*.8 , angle_direction) - 4;
		
		if(CURRENT_WORLD)
		{
			_y += 10
		}
		
		//if(!inside_ground) _y -= 8
		
		draw_sprite_ext(spr_drill_base,0,x + _x ,y + _y , 1.1 , 1 , angle_direction , image_blend , 1);
	
		_dist = 14
		_x += lengthdir_x(_dist , angle_direction);
		_y += lengthdir_y(_dist , angle_direction);
			
		drill.x = x + _x;
		drill.y = y + _y;
		
		var _color = image_blend;
		
		if(danger_energy || current_energy <= 0)
		{
			var _frc = max(current_energy / percent_show_danger , 0)
			_color = merge_colour(c_dkgray ,_color , _frc)
		}
		
		
		var _sprite = drill_sprites[drill.image_index];
		var _image = drill_image_index;
		draw_sprite_ext(_sprite,_image,x + _x ,y + _y ,  xscale , yscale , drill.image_angle , _color , 1)
		
		gpu_set_fog(false , c_white , 1,0);
	}
	
	draw_topbar = function() {
		var _border = 6;
		
		draw_sprite_stretched_ext(spr_bar, 0, _border - 2, _border + 2, GUI_WIDTH - _border * 2, 36, #000000, 1);
		draw_sprite_stretched_ext(spr_bar, 0, _border, _border, GUI_WIDTH - _border * 2, 36, #db6395, 1);
	}
	
	draw_drop_bar = function()
	{
		var _x = GUI_WIDTH + 7;
		var _y = 40;
		var _num = array_length(INVENTORY);
		
		draw_set_valign(fa_bottom)
		draw_set_halign(fa_center)
		draw_set_font(fnt_pb);
		
		for(var i = 0 ; i < _num ; i++)
		{
			var __x = _x + (i * SLOT_WIDTH) - SLOT_WIDTH * _num;
			draw_sprite_ext(spr_hud, 0,__x,_y, 1, 1, 0, #db6395, 1);
			
			if(INVENTORY[i]!=undefined)
			{
				draw_sprite_ext(INVENTORY[i].slot_sprite,0,__x - 2,_y - (SLOT_WIDTH/2) + 2,1,1,0,#000000,1)
				draw_sprite_ext(INVENTORY[i].slot_sprite,0,__x,_y - (SLOT_WIDTH/2),1,1,0,c_white,1)
				
				var __y = _y + 1;
				
			}
			if (i == INVENTORY_OPTION_SELECTED) draw_sprite(spr_hud, 1,__x,_y);
			
			if(INVENTORY[i]!=undefined) {
				__x += 8;
				_y += 1;
				var _txt = $"{INVENTORY[i].slot_stack_current_number}";
				
				draw_cool_text(__x - 1, _y + 1, _txt,, #000000);
				draw_cool_text(__x , _y , _txt);
				__x -= 8;
				_y -= 1;
			}
		}
		
		draw_set_font(-1);
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)
		
	}
	
	draw_battery_life = function()
	{
		if(CURRENT_WORLD) return;
		//draw_healthbar(20,20,100 + energy_max,30,current_energy/energy_max * 100 , c_black , c_red , c_white , 0,true , true);
		
		static _x = 9;
		static _y = 55;
		static _x_offset = 3;
		static _y_offset = 0;
		
		var  _scale = energy_max / 150;
		
		var _hei = sprite_get_height(spr_battery_bar) * _scale - (8);
		var _pot = current_energy/energy_max;
		var _color = merge_colour(c_yellow , c_green,_pot);
		if(current_energy < percent_show_danger)
		{
			_color = c_red;
		}
		
		draw_sprite_ext(spr_battery_bar, 1, _x - 2, _y + 2, 1, _scale, 0, #000000, 1);
		
		draw_healthbar(_x + _x_offset , _y + _y_offset + 2 , _x + 13 , _y + _y_offset + _hei,_pot*100,c_black , _color , _color , 3 , true , false);
		var _frc = wave(64,0,2)
		
		draw_sprite_ext(spr_battery_bar, 0, _x, _y , 1, _scale, 0, c_white, 1);
	}
	
	x_gui_normal	= -20;
	x_gui_candy		= 36;
	x_gui		 	= x_gui_candy;
	
	draw_gui = function()
	{
		draw_topbar();
		
		x_gui = lerp(x_gui , CURRENT_WORLD ? x_gui_normal : x_gui_candy,.1);
		
		var _scrib = scribble($"[fnt_pb_o] ${string_format_nlarge(GAME_INFO.coins)}");
	
		var _x = 28;
		var _y = 26;
	
		_scrib
			.align(fa_left, fa_middle)
			.flash(#000000, 1)
			.draw(
				_x - 1,
				_y + 1
			)

		_scrib
			.flash(#ffffff, 0)
			.draw(
				_x,
				_y
			)
		
		draw_sprite_ext(spr_money_icon, 0, _x - 1, _y + 1, 1, 1, 0, #000000, 1);
		draw_sprite_ext(spr_money_icon, 0, _x, _y, 1, 1, 0, #ffffff, 1);
		
		if(!CURRENT_WORLD)
		{
			var _scrib = scribble($"[fnt_pb_o]{$"Profundidade: {max(round((y+max_y_outside)/32),0)} m"}");
			
			_scrib
				.align(fa_left, fa_middle)
				.flash(#000000, 1)
				.draw(
					x_gui - 1,
					55 + 1
				)

			_scrib
				.flash(#ffffff, 0)
				.draw(
					x_gui,
					55
				)
		}
		
		draw_set_font(-1);
		
		draw_battery_life();
		
		draw_drop_bar()
	}
	
	draw_option_on_elevator = function()
	{
		return;
		if(chosing_level)
		{
			draw_text(x+16,y-16,current_choose);
		}
	}
	
	draw_border = function(){}
	draw_reload_feedback = function(){}

#endregion

#region funções

	check_interactables = function()
	{
		var _return = true;
		var _ins = instance_place(x,y,obj_interact_item_father);
		if(_ins)
		{
			if(_ins.can_be_interacted(id))
			{
				_return = false;
				_ins.is_hovered = true;
				
				if(check_confirm())
				{
					var _name = object_get_name(_ins.object_index);
					
					if(!array_contains(GAME_INFO.itens_interact,_name))
					{
						array_push(GAME_INFO.itens_interact,_name)
					}
					
					_ins.when_interacted(id)
				}
			}
		}
		
		return _return;
	}
	
	update_damage = function()
	{
		damage = power(2 , damage_level);
	}
	update_damage();
	
	exit_ground = function(_state = state_outside)
	{
		inside_ground = false;
		vspd = -8;
		state = _state;
		v_spd = 0;
		
		sfx_play(snd_dirt_exit);
		
		sprite_index = spr_player_normal_jump;
		
		y = min(y , -max_y_outside);
	}
	
	enter_ground = function(_state = state_walk)
	{
		state = _state;
		y = max(y , -max_y_outside + 8)
		vspd = 8;
		v_spd = 8;
		inside_ground = true;
		
		sfx_play(snd_dirt_enter);
		
		sprite_index = spr_player_cake;
	}
	
	consume_energy = function(_value)
	{
		if(inside_ground && visible && image_alpha > 0.1)
		{
			current_energy -= _value
		}
	}
	
	inventory_handler = function()
	{	
		INVENTORY_OPTION_SELECTED += mouse_wheel_down() - mouse_wheel_up()
		INVENTORY_OPTION_SELECTED = wrap(INVENTORY_OPTION_SELECTED,0,array_length(INVENTORY)-1)

		if(mouse_check_button(mb_middle) || keyboard_check_pressed(ord("Q")) && inside_ground)
		{
			drop_mineral()
		}
	}
	
	drop_mineral =  function()
	{
		var _drop = INVENTORY[INVENTORY_OPTION_SELECTED];
		
		if(_drop == undefined) return;
				
		var _ins = instance_create_layer(x,y,"Drops",_drop.slot_object);
		_ins.sprite_index = _drop.slot_sprite;				
		_ins.value		  = _drop.slot_value;				
		_ins.rarity 	  = _drop.slot_rarity;				
		_ins.stack_max	  = _drop.slot_stack_base;			
		_ins.number_to_add= _drop.slot_stack_current_number;
		
		_ins.timer_to_be_collected = GAME_SPEED*2;
		
				
		INVENTORY[INVENTORY_OPTION_SELECTED] = undefined;
	}
	
	check_horizontal_movement = function()
	{
		var _return = ( keyboard_check(ord("D")) - keyboard_check(ord("A")));
		return _return
	}
	
	check_confirm = function()
	{
		return keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("E"));
	}
	
	//lerp circular que aponta a broca pro canto certo
	rotate_drill = function(_direction , _force)
	{

		angle_direction = lerp_angle(angle_direction,_direction , _force)
		angle_direction = wrap(angle_direction,0,360);
		
		drill.image_angle = lerp_angle(angle_direction,_direction , _force*.8)
		drill.image_angle = wrap(drill.image_angle,0,360);
		
	}

	can_i_be_hurt = function(_other)
	{
		return current_timer_invincible <=0 && image_alpha > 0;
	}

	max_y = (CHUNK_MAX * CHUNK_HEIGHT) + CHUNK_HEIGHT;
	
	last_drill_position = new vector2(drill.x,drill.y);
	collision=function()
	{
		var _multiply = speed_multiply_timer > 0 ? current_speed_multiply : 1
	
		var __x = hspd * _multiply;
		var __y = vspd * _multiply;
	
		if(!inside_ground)
		{
		
			if(CURRENT_WORLD) __x *= -1;
		
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
			var _movement = (abs(__x) + abs(__y))/50 * move_energy_cost
			consume_energy(max(_movement , still_energy_cost));
		
		
			x += __x;
			y += __y;
		}
		
		var _offset = CURRENT_WORLD ? -128 : 16
		x = clamp(x , _offset , room_width - _offset);
		//y = min(y , max_y);
		
		
		var _last = variable_clone(last_drill_position);
			
		var _len = sprite_get_width(drill_sprites[drill.image_index]);
		var _x = lengthdir_x(_len , angle_direction);
		var _y = lengthdir_y(_len , angle_direction);
				
		last_drill_position.x = drill.x + _x
		last_drill_position.y = drill.y + _y
		
		if(inside_ground)
		{
			var _min = 20
			if (abs(hspd) + abs(vspd)) > 1 && last_drill_position.y > _min
			{	
				
				var _dist = ceil( point_distance(_last.x,_last.y,last_drill_position.x,last_drill_position.y) ) * .1;
				if(_dist < 128)
				{
					for(var i = 0 ; i < _dist ; i++)
					{
						var ___x = lerp(_last.x,last_drill_position.x,i/_dist)
						var ___y = lerp(_last.y,last_drill_position.y,i/_dist)
				
						if(___y > _min)
						{
							instance_create_layer(___x,___y,"GroundEffect",obj_player_path);
						}
				
					}
				}
			}
	
			if(!player_dead && (y < -max_y_outside ||  (y < -max_y_outside + 28 && vspd<0 )))
			{
		
				exit_ground();
				image_alpha = 1;
			}
		}
	}

#endregion

h_spd = 0;
v_spd = 0;

#region state machine debaixo da terra

	//andando debaixo da terra
	state_walk = function()
	{
		image_blend = c_white
		
		hurt_flag = false;
		
		using_elevator = false;
		
		check_interactables();
	
		var _direction = point_direction(x,y,mouse_x,mouse_y);
		var _spd = mouse_check_button(mb_left) && (point_distance(x,y,mouse_x,mouse_y) > 16) && !is_mouse_over_debug_overlay();
		
		rotate_drill(_direction, .1 + (_spd*.2))
		
		var _hspd = lengthdir_x(1,angle_direction)
		var _vspd = lengthdir_y(1,angle_direction)
		
		var _frc_speed = (current_energy <= 0) ? current_speed / 3 : current_speed;
		
		var _dist = clamp(point_distance(x,y,mouse_x,mouse_y) / 100 , 0 , 1);
	
		h_spd = lerp(h_spd , _hspd * current_speed * _spd * _dist , aceleration);
		v_spd = lerp(v_spd , _vspd * current_speed * _spd * _dist , aceleration);
		
		
		hspd	= lerp(hspd , h_spd , acel_after_attack);
		vspd	= lerp(vspd , v_spd , acel_after_attack);
		
		current_drill_image_speed = (abs(h_spd) + abs(v_spd))*1.5
	
		if(_spd || (abs(hspd) + abs(vspd))>1)
		{
			check_entity_to_drill();
		}
		
	
		if(number_is_between(angle_direction,90,270)) look_at = -1
		else look_at = 1;
		
		
		
		if(has_dash && mouse_check_button(mb_right))
		{
			state = state_dash_load;
			
			current_dash_timer = 0;
			current_dash_load_timer = 0
		}
	}
	
	//carregando dash
	state_dash_load = function()
	{
		
		current_drill_image_speed = 10;
		
		image_blend = c_orange;
		
		hspd	= lerp(hspd , 0 , aceleration);
		vspd	= lerp(vspd , 0 , aceleration)
		h_spd = hspd;
		v_spd = vspd;
		
		var _direction = point_direction(x,y,mouse_x,mouse_y);
	
		rotate_drill(_direction, .3)
	
		if(number_is_between(angle_direction,90,270)) look_at = -1
		else look_at = 1;
		
		
		current_dash_load_timer = clamp(current_dash_load_timer+1,0,dash_load_timer)
		
		if(!mouse_check_button(mb_right))
		{
			state = state_dash_released;
			current_dash_timer = 0;
			
			rotate_drill(_direction, .8)
			
			sfx_play(snd_player_dash, 1, .15);
			
			var _x = lengthdir_x(dash_distance_max ,angle_direction)
			var _y = lengthdir_y(dash_distance_max ,angle_direction)
			var _dist = point_distance(x,y,x+_x,y+_y) / dash_flow_timer;
			
			var _frc =.5 + (current_dash_load_timer / dash_load_timer)*.5
			
			dash_speed = _dist * _frc;
			
			hspd = lengthdir_x(dash_speed,angle_direction);
			vspd = lengthdir_y(dash_speed,angle_direction);
			
			consume_energy(dash_bust_energy_cost);
		}
	}
	
	//indo pra frente
	state_dash_released = function()
	{
		
		consume_energy(state_dash_energy_cost);
		
		image_blend = c_red;
		
		var _h_spd = lengthdir_x(dash_speed + ((current_energy < 0) * 5) , angle_direction);
		var _v_spd = lengthdir_y(dash_speed + ((current_energy < 0) * 5) , angle_direction);
		
		h_spd = lerp(h_spd , _h_spd , .1);
		v_spd = lerp(v_spd , _v_spd , .1);
		
		hspd = lerp(hspd ,h_spd,.3 * acel_after_attack)
		vspd = lerp(vspd ,v_spd,.3 * acel_after_attack)
		
		current_drill_image_speed = (abs(h_spd) + abs(v_spd)) * 3;
		
		current_dash_timer++;
		if(current_dash_timer >= dash_flow_timer)
		{
			state = state_walk;
		}
		
		check_entity_to_drill(dash_damage_multiply,dash_timer_offset_attacks,push_force_when_attack_dash);
	}
	
	state_goup = function()
	{
		image_alpha = 0;
		vspd = lerp(vspd , -100 , .05);
		hspd = 0;
		
		using_elevator = true;
		
		current_energy = max(current_energy,1);
	}
	
	state_hurt = function()
	{
		if !hurt_flag {
			sfx_play([snd_player_hurt1, snd_player_hurt2]);
			
			hurt_flag = true;
		}
		
		hspd	= lerp(hspd , 0 , aceleration * acel_after_attack * .8);
		vspd	= lerp(vspd , 0 , aceleration * acel_after_attack * .8);
		
		h_spd = hspd;
		v_spd = hspd;
		
		timer_stunned--;
		
		if(timer_stunned<=0)
		{
			state = state_walk;
		}
	}
	
	state_godown = function()
	{
		
		x = lerp(x , elevator_follow.x , .05 * acel_after_attack)
		y = lerp(y , elevator_follow.y , .02 * acel_after_attack)
		
		h_spd = 0;
		v_spd = 0;
		
		using_elevator = true;
		
		if(instance_place(x,y,elevator_follow))
		{
			state = state_walk;
			image_alpha = 1;
			chosing_level = false;
			
			x = elevator_follow.x;
			y = elevator_follow.y;
			
			var _direction = random_range(270-5,270+5);
			hspd = lengthdir_x(5 , _direction);
			vspd = lengthdir_y(5 , _direction);
			angle_direction = _direction;
		}
		
	}
	
	trigger_death = function()
	{	
		if(!player_dead && image_alpha > 0)
		{
			
			if(y - 64 <= 0)
			{
				exit_ground();
				return;
			}
			
			player_dead = true;
			camera_set_zoom(.25);
			state = state_death;
			
			drop_half(x,y);
			
			sfx_play(snd_player_death);
		
			call_later(1.5 , time_source_units_seconds , function()
			{
				instance_create_depth(0, 0, 0, obj_transition).action = fx() 
				{ 
					with(obj_player)
					{
						exit_ground();
						player_dead = false;
						current_energy = energy_max;
						vspd = 0;
						
					}
					
					with(obj_mineral_drop_father)
					{
						instance_destroy();
					}
					
					obj_camera.y = obj_player.y-200
					camera_set_zoom(.5,1);
				};
			})
		}
	}
	state_death = function()
	{
		vspd = 0;
		hspd = 0;

		sprite_index = spr_player_normal_prepare_jump;
	}

	state = state_walk;

#endregion

#region state machine acima da terra

	gravity_force = .6;
	max_y_outside = 32
	on_ground = false;
	jump_force = 5;

	state_outside = function()
	{
		current_drill_image_speed = 0;
		
		using_elevator = false;
		
		image_blend = c_white
		
		var _frc = !CURRENT_WORLD ? 1 : -1;
		
		on_ground = instance_place(x,y+_frc,obj_collision);
	
		var _hspd = speed_walking * check_horizontal_movement() * !(instance_exists(obj_choose_level));
	
		hspd = lerp(hspd , _hspd , .1);
	
		current_energy = clamp(current_energy+.5 , 0 , energy_max);
		
	
		if(!on_ground)
		{
			vspd += gravity_force * _frc;
			vspd = clamp(vspd , -max_vspd  , max_vspd);
			
			sprite_index = (vspd * _frc) > 0 ? spr_player_normal_fall : spr_player_normal_jump;
		}
		else
		{
			
			sprite_index = (_hspd == 0) ? spr_player_normal_idle : spr_player_normal_walk;
		}
	
		var _direction = point_direction(x,y,mouse_x,mouse_y);
		var _spd = mouse_check_button(mb_left);
		
		var _point = _direction;
		rotate_drill(_direction, .6)
	
		if(sign(_hspd) != 0) 
		{
			look_at = sign(_hspd);
		}
		
		
		if(on_ground)
		{
			var _can = check_interactables();
			
			var _mouse = number_is_between(angle_direction,180+1,360-1) && mouse_check_button_pressed(mb_left)
			var _keybpard = keyboard_check(ord("S")) && keyboard_check(vk_space);
			if(can_cave && (_mouse || _keybpard))
			{
				vspd = -5;
				enter_ground();
			}
			else
			if(_can && check_confirm())
			{
				sfx_play([snd_player_jump1, snd_player_jump2]);
				vspd = -8 * _frc;
				image_index = 0;
			}
		}
	}
	
	state_select = function()
	{
		
		image_blend = c_white
		
		sprite_index = spr_player_normal_idle;
		
		on_ground = instance_place(x,y+1,obj_collision);
		hspd = lerp(hspd , 0 , .1);
		if(!on_ground)
		{
			vspd += gravity_force;
		}
		
		
		chosing_level = true;
		current_choose += keyboard_check_pressed(ord("D")) + keyboard_check_pressed(ord("S")) - ( keyboard_check_pressed(ord("W")) + keyboard_check_pressed(ord("A")) )
		current_choose = wrap(current_choose , 0 , GAME_INFO.max_chunk_achiev div 10);
		
		if(check_confirm())
		{
			if(current_choose <= 0)
			{
				state = state_outside;
				chosing_level = false;
				
			}
			else
			{
				var _index = noone
				with(obj_interact_item_father)
				{
					if(variable_instance_exists(id , "id_chunk"))
					{
						if(id_chunk == other.current_choose)
						{
							_index = id;
						}
					}
				}
				
				if(_index != noone)
				{
					elevator_follow = _index;
					
					image_alpha = 0;
					enter_ground(state_godown)
				}
			}
		}
	}

	if(y<=-max_y_outside || !can_cave)
	{
		exit_ground();
		inside_ground = false;
		using_elevator = false;
		state = state_outside;
		vspd = 0;
		y = ystart;
	}
	
	if true //(CURRENT_WORLD)
	{
		y = -2710;
		can_cave = false;
	}
	
	state_prepare_fall = function()
	{
		current_energy = lerp(current_energy , energy_max , .1);
		can_cave = true;	
		have_drill = true;
		
		if sprite_index != spr_player_normal_prepare_jump {
			sfx_play(snd_player_gravity_intro);
			
			sprite_index = spr_player_normal_prepare_jump;
		}
		
		var _direction = CURRENT_WORLD ? 270 : 90;
		rotate_drill(_direction, .2)
		
		hspd = 0;
		vspd = 0;
	}
	state_falling = function()
	{
		current_energy = energy_max;
		
		have_drill = false;
		image_blend = c_white
		
		var _frc = !CURRENT_WORLD ? 1 : -1;
		
		on_ground = instance_place(x,y+_frc,obj_collision);
	
		var _hspd = speed_walking * check_horizontal_movement();
		hspd = lerp(hspd , _hspd , .1);
		
		var _diff = 16;
		x = clamp(x,room_width/2-_diff,room_width/2+_diff)
		
		if sprite_index != spr_player_normal_falling {
			sfx_play(snd_inverted_gravity);
			
			sprite_index = spr_player_normal_falling;
		}
		
		angle += 8.5

		
		if(on_ground)
		{
			have_drill = true;
			angle = 0;
			
			obj_game_control.can_pause = true;
			
			sfx_play(snd_player_land, .33);
			
			if can_cave {
				music_swap(mus_underground);
			}
			else {
				music_swap(mus_overworld);
			}
			
			if(can_cave && mouse_check_button(mb_left))
			{
				enter_ground();
			}
			else
			{
				state = state_outside;
			}
		}
		else
		{
			vspd += gravity_force * _frc;
			vspd = clamp(vspd , -max_vspd  , max_vspd);
		}
	}
	
	chosing_level = false;
	current_choose = max(0,GAME_INFO.max_chunk_achiev div 10);
	elevator_follow = noone;
	

#endregion

#region upgrades

	update_upgrades_values = function()
	{
		drill_level		= UPGRADES.drill_level				 
		damage			= power(2 , UPGRADES.drill_damage)			 
		eletric_drill	=  (42 * power(1.75,UPGRADES.drill_eletric)) * bool(UPGRADES.drill_eletric)	
		drill.image_index = clamp(UPGRADES.drill_range , 0 ,drill.image_number-1)				 
		current_speed	= base_speed + UPGRADES.drill_speed			
		
		////Dash
		has_dash = UPGRADES.dash_unlocked			 
		dash_colector = UPGRADES.dash_colector			 
		var _base_distance = 150;
		var _max_distance = 350;
		dash_distance_max = _base_distance + (UPGRADES.dash_distance * ((_max_distance - _base_distance) / 10))			 
		
		dash_bust_energy_cost			= lerp( 15	 , 2.5  , UPGRADES.dash_eficiency/4);
		state_dash_energy_cost			= lerp( 0.12 , 0.01 , UPGRADES.dash_eficiency/4);	
		dash_damage_multiply			= lerp( 1.6  , 5	, UPGRADES.dash_damage / 5);			 	 
		critical_dash_damage_multiply	= lerp( 1.2  , 3	, UPGRADES.dash_critic / 4);
		dash_load_timer					= lerp( 120  , 30	, UPGRADES.dash_load / 4);			
		
		////Energy
		energy_max = lerp( 140 , 350 , UPGRADES.energy_max / 20);
		move_energy_cost			= lerp( 0.4 , 0.1	, UPGRADES.energy_movement / 3 );
		damage_energy_cost_multiply = lerp( 2	, .5	, UPGRADES.energy_drill_damage  / 20);
		still_energy_cost = lerp(.02 , 0 , UPGRADES.energy_still / 2);		
		
		timer_invincible = lerp( GAME_SPEED , GAME_SPEED * 2.5	, UPGRADES.energy_invencibility / 3	);
		defensive_multipliyer	 = lerp( 1			, .5		, UPGRADES.energy_resistency	/ 30);
		
		life_steal_percent = (UPGRADES.energy_leech/4) * .15;
		
		////Extras
		
		while((UPGRADES.ext_slot_total+2) > array_length(INVENTORY))
		{
			array_push(INVENTORY,undefined)
		}
		
		while((UPGRADES.ext_selling_slots+3) > array_length(SELL_ARRAY))
		{
			array_push(SELL_ARRAY,undefined)
		}
		
		obj_sell_manager.selling_potency = power(2.4 , UPGRADES.ext_selling_clients);
//		
		 
		//UPGRADES.ext_drill_bot			 
		//UPGRADES.ext_drill_bot_eficiency 

		//UPGRADES.ext_tnt					 
		//UPGRADES.ext_tnt_area			 
		//UPGRADES.ext_tnt_damage			 	 
		
		//UPGRADES.ext_life_saver			 
		pointer = UPGRADES.ext_pointer;			 

//		////Fogão

		//UPGRADES.cooker_number			 
		//UPGRADES.cooker_faster			 
		//UPGRADES.cooker_seasoning		 
		//UPGRADES.cooker_ideal			 
		//UPGRADES.cooker_propaganda		 
		//UPGRADES.cooker_auto				 
		//UPGRADES.cooker_selling			 
		
	}
	
	call_later(1,time_source_units_frames,update_upgrades_values);
#endregion

#region DEBUGGER

	my_debugger = noone;

	#region OLD DEBUG COM AS VARIAVEIS DO PLAYER
	//debug_create = function()
	//{
	//	my_debugger = dbg_view("CAMERA OPTIONS",true)

	//	//dbg_section("Player");
	//	//dbg_text("Coisas");
	//	//dbg_checkbox(ref_create(self , "variable_name"),"")
	//	//dbg_slider(ref_create(self , "variable_name") , 0 , 3,"TEXTO: ",0.1)
	//	//dbg_text_input(	ref_create(self , "variable_name")	,"TEXTO: "	,DBG_TYPE_REAL)
		
	//	dbg_section("Movimentação");
		
	//		dbg_text_input(ref_create(self , "speed_walking")	 , "speed_walking"		, DBG_TYPE_REAL);
	//		dbg_text_input(ref_create(self , "current_speed")	 , "current_speed"		, DBG_TYPE_REAL);
	//		dbg_text_input(ref_create(self , "aceleration"	)	 , "aceleration"		, DBG_TYPE_REAL);
	//		dbg_text_input(ref_create(self , "move_energy_cost") , "move_energy_cost"	, DBG_TYPE_REAL);
		
	//	dbg_section("Dash");
		
	//		dbg_text_input(ref_create(self , "dash_load_timer"	)		, "dash_load_timer"		, DBG_TYPE_INT);
	//		dbg_text_input(ref_create(self , "dash_distance_max"	)	, "dash_distance_max"	, DBG_TYPE_INT);
	//		dbg_text_input(ref_create(self , "dash_flow_timer"	)		, "dash_flow_timer"		, DBG_TYPE_INT);
			
	//		dbg_text_input(ref_create(self , "dash_damage_multiply"	)	, "dash_damage_multiply"		, DBG_TYPE_REAL);
			
	//		dbg_text_input(ref_create(self , "dash_bust_energy_cost")	, "dash_bust_energy_cost"		, DBG_TYPE_REAL);
	//		dbg_text_input(ref_create(self , "state_dash_energy_cost")	, "state_dash_energy_cost"		, DBG_TYPE_REAL);
		
	//	dbg_section("Broca");
		
	//		dbg_text_input(ref_create(self , "damage")						, "damage"						, DBG_TYPE_REAL);
	//		dbg_text_input(ref_create(self , "damage_level")				, "damage_level"				, DBG_TYPE_REAL);

	//		dbg_button("Free current slot" , update_damage);
			
	//		dbg_text_input(ref_create(self , "drill_level")					, "drill_level"					, DBG_TYPE_REAL);
	//		dbg_text_input(ref_create(self , "dash_damage_multiply")		, "dash_damage_multiply"		, DBG_TYPE_REAL);
			
	//		dbg_text_input(ref_create(self , "damage_energy_cost_multiply")	, "damage_energy_cost_multiply"	, DBG_TYPE_REAL);
																			  
	//		dbg_text_input(ref_create(self , "timer_offset_attacks")		, "timer_offset_attacks"		, DBG_TYPE_INT);
	//		dbg_text_input(ref_create(self , "dash_timer_offset_attacks")	, "dash_timer_offset_attacks"	, DBG_TYPE_INT);
																			  
	//		dbg_text_input(ref_create(self , "push_force_when_attack")		, "push_force_when_attack"		, DBG_TYPE_REAL);
	//		dbg_text_input(ref_create(self , "push_force_when_attack_dash")	, "push_force_when_attack_dash"	, DBG_TYPE_REAL);
		
	//	dbg_section("Energy");
		
	//		dbg_text_input(ref_create(self , "energy_max")			, "energy_max"		, DBG_TYPE_REAL);
	//		dbg_text_input(ref_create(self , "current_energy")		, "current_energy"	, DBG_TYPE_REAL);
			
			
	//		dbg_text_input(ref_create(self , "still_energy_cost")			, "still_energy_cost"			, DBG_TYPE_REAL);
	//		dbg_text_input(ref_create(self , "move_energy_cost")			, "move_energy_cost"			, DBG_TYPE_REAL);
	//		dbg_text_input(ref_create(self , "dash_bust_energy_cost")		, "dash_bust_energy_cost"		, DBG_TYPE_REAL);
	//		dbg_text_input(ref_create(self , "damage_energy_cost_multiply")	, "damage_energy_cost_multiply"	, DBG_TYPE_REAL);
	//		dbg_text_input(ref_create(self , "state_dash_energy_cost")		, "state_dash_energy_cost"		, DBG_TYPE_REAL);
			
	//	dbg_section("Inventário")
		
	//		dbg_button("Add Slot" , function()
	//		{
	//			array_push(INVENTORY,undefined);
	//		})
			
	//		dbg_button("Remove Slot" , function()
	//		{
	//			if(array_length(INVENTORY) > SLOTS_MINERAL_MIN)
	//			{
	//				var _ins = array_pop(INVENTORY);
					
	//				INVENTORY_OPTION_SELECTED = qwrap(INVENTORY_OPTION_SELECTED,0,array_length(INVENTORY)-1)
					
	//				delete _ins;
	//			}
	//		})
			
			
	//		dbg_button("Free current slot" , drop_mineral);
	
	//}
	#endregion

	debug_create = function()
	{
		my_debugger = dbg_view("CAMERA OPTIONS",true)

		//dbg_section("Player");
		//dbg_text("Coisas");
		//dbg_checkbox(ref_create(self , "variable_name"),"")
		//dbg_slider(ref_create(self , "variable_name") , 0 , 3,"TEXTO: ",0.1)
		//dbg_text_input(	ref_create(self , "variable_name")	,"TEXTO: "	,DBG_TYPE_REAL)
		
		dbg_section("Botões mágicos");
		
			dbg_text_input(ref_create(GAME_INFO , "coins")	  ,"Moedas"			, DBG_TYPE_INT);
			
			dbg_button("Imortal"			 , function()
			{
				current_timer_invincible = current_timer_invincible > 0 ? 0 : infinity;
				current_energy = 3000000;
			});
			dbg_button("DANO MAX"			 , function()
			{
				damage = power(2 , 30);
				drill_level = 10;
			});
			dbg_button("Resetar player"		 , function()
			{
				delete GAME_INFO;
				GAME_INFO = new create_saveable_info();
			})
			dbg_button("Matar o player"		 , function()
			{
				current_energy = -1;
			});
			dbg_button("TP para o teleporte" , function()
			{
				
				enter_ground();
				var _ins = instance_nearest(x,y,obj_teleport_botton)
				x = _ins.x;
				y = _ins.y;
				
			});
			dbg_button("Atualizar variáveis" , update_upgrades_values);
			dbg_button("SAVE"				 , save_game);
			
			
		
		dbg_section("Broca");
		
			dbg_text_input(ref_create(UPGRADES , "drill_level")	  ,"drill_level"			, DBG_TYPE_INT);
			dbg_text_input(ref_create(UPGRADES , "drill_damage")  ,"drill_damage"  			, DBG_TYPE_INT);
			dbg_text_input(ref_create(UPGRADES , "drill_eletric") ,"drill_eletric" 			, DBG_TYPE_INT);
			dbg_text_input(ref_create(UPGRADES , "drill_range"	) ,"drill_range"			, DBG_TYPE_INT);
			dbg_text_input(ref_create(UPGRADES , "drill_speed")   ,"drill_speed"   			, DBG_TYPE_INT);
		
		dbg_section("Dash");
		
			dbg_text_input(ref_create(UPGRADES , "dash_unlocked")	, "dash_unlocked"		, DBG_TYPE_INT);
			dbg_text_input(ref_create(UPGRADES , "dash_colector")	, "dash_colector"		, DBG_TYPE_INT);
			dbg_text_input(ref_create(UPGRADES , "dash_distance")	, "dash_distance"		, DBG_TYPE_INT);
			dbg_text_input(ref_create(UPGRADES , "dash_eficiency")	, "dash_eficiency"		, DBG_TYPE_INT);
			dbg_text_input(ref_create(UPGRADES , "dash_damage")		, "dash_damage"			, DBG_TYPE_INT);
			dbg_text_input(ref_create(UPGRADES , "dash_load")		, "dash_load"			, DBG_TYPE_INT);
			dbg_text_input(ref_create(UPGRADES , "dash_critic")		, "dash_critic"			, DBG_TYPE_INT);
		
		dbg_section("Energy");
		
		dbg_text_input(ref_create(UPGRADES , "energy_max")			, "energy_max"			, DBG_TYPE_INT);
		dbg_text_input(ref_create(UPGRADES , "energy_movement")		, "energy_movement"		, DBG_TYPE_INT);
		dbg_text_input(ref_create(UPGRADES , "energy_drill_damage")	, "energy_drill_damage"	, DBG_TYPE_INT);
		dbg_text_input(ref_create(UPGRADES , "energy_still")		, "energy_still"		, DBG_TYPE_INT);
		dbg_text_input(ref_create(UPGRADES , "energy_invencibility"), "energy_invencibility", DBG_TYPE_INT);
		dbg_text_input(ref_create(UPGRADES , "energy_resistency")	, "energy_resistency"	, DBG_TYPE_INT);
		dbg_text_input(ref_create(UPGRADES , "energy_leech")		, "energy_leech"		, DBG_TYPE_INT);
		
		dbg_section("Extras");
		
		dbg_text_input(ref_create(UPGRADES , "ext_slot_total")				, "ext_slot_total"				, DBG_TYPE_INT);	
		dbg_text_input(ref_create(UPGRADES , "ext_slot_lenght")				, "ext_slot_lenght"				, DBG_TYPE_INT);	
		dbg_text_input(ref_create(UPGRADES , "ext_selling_slots")			, "ext_selling_slots"			, DBG_TYPE_INT);	
		dbg_text_input(ref_create(UPGRADES , "ext_selling_clients")			, "ext_selling_clients"			, DBG_TYPE_INT);	
		dbg_text_input(ref_create(UPGRADES , "ext_magnet")					, "ext_magnet"					, DBG_TYPE_INT);	
		dbg_text_input(ref_create(UPGRADES , "ext_drill_bot")				, "ext_drill_bot"				, DBG_TYPE_INT);	
		dbg_text_input(ref_create(UPGRADES , "ext_drill_bot_eficiency")		, "ext_drill_bot_eficiency"		, DBG_TYPE_INT);	
		dbg_text_input(ref_create(UPGRADES , "ext_tnt")						, "ext_tnt"						, DBG_TYPE_INT);	
		dbg_text_input(ref_create(UPGRADES , "ext_tnt_area")				, "ext_tnt_area	"				, DBG_TYPE_INT);	
		dbg_text_input(ref_create(UPGRADES , "ext_tnt_damage")				, "ext_tnt_damage"				, DBG_TYPE_INT);	
		dbg_text_input(ref_create(UPGRADES , "ext_more_drops")				, "ext_more_drops"				, DBG_TYPE_INT);	
		dbg_text_input(ref_create(UPGRADES , "ext_lost_drops")				, "ext_lost_drops"				, DBG_TYPE_INT);	
		dbg_text_input(ref_create(UPGRADES , "ext_life_saver")				, "ext_life_saver"				, DBG_TYPE_INT);	
		dbg_text_input(ref_create(UPGRADES , "ext_pointer")					, "ext_pointer"					, DBG_TYPE_INT);	
			
		dbg_section("Cooker")
		
		dbg_text_input(ref_create(UPGRADES , "cooker_number")		, "cooker_number"		, DBG_TYPE_INT);	
		dbg_text_input(ref_create(UPGRADES , "cooker_faster")		, "cooker_faster"		, DBG_TYPE_INT);	
		dbg_text_input(ref_create(UPGRADES , "cooker_seasoning")	, "cooker_seasoning"	, DBG_TYPE_INT);	
		dbg_text_input(ref_create(UPGRADES , "cooker_ideal")		, "cooker_ideal	"		, DBG_TYPE_INT);	
		dbg_text_input(ref_create(UPGRADES , "cooker_propaganda")	, "cooker_propaganda"	, DBG_TYPE_INT);	
		dbg_text_input(ref_create(UPGRADES , "cooker_auto")			, "cooker_auto"			, DBG_TYPE_INT);	
		dbg_text_input(ref_create(UPGRADES , "cooker_selling")		, "cooker_selling"		, DBG_TYPE_INT);	
		
		dbg_section("Slots")
		
		dbg_button("Add Slot" , function()
		{
			array_push(INVENTORY,undefined);
		})
			
		dbg_button("Remove Slot" , function()
		{
			if(array_length(INVENTORY) > SLOTS_MINERAL_MIN)
			{
				var _ins = array_pop(INVENTORY);
					
				INVENTORY_OPTION_SELECTED = qwrap(INVENTORY_OPTION_SELECTED,0,array_length(INVENTORY)-1)
					
				delete _ins;
			}
		})
			
		dbg_button("Free current slot" , drop_mineral);
		
		//dbg_button("Free current slot" , drop_mineral);
	
	}

	debug_destroy = function()
	{
		if(dbg_view_exists(my_debugger))
		{
			dbg_view_delete(my_debugger);
		}
	
		show_debug_overlay(false);
	}

#endregion

