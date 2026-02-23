
event_inherited();

angle_direction = 0;
shoot_speed = 0;

drill = instance_create_depth(x,y,depth,obj_drill_hitbox)
drill.owner = id;

#region mineirando

	inside_ground = true;
	
	drill_level = 2;

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
	
	drill_white_timer = 0;
	
	check_entity_to_drill = function(_damage_multiply = 1 , _timer_betwen_hits = timer_offset_attacks , oposite_speed = push_force_when_attack)
	{
		if(current_timer_offset_attacks>0 || current_timer_invincible > 0) return;
		
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
			
			var _mult = min(_damage_multiply,_current.life)
			
			
			var _can_attack = drill_level >= _current.resistency;
			current_energy -= (!_can_attack*.5) + (damage_energy_cost_multiply) * _mult;
			if(_can_attack)
			{
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


	timer_stunned = 0;
	defensive_multipliyer = 2;
	timer_invincible = GAME_SPEED*.8;
	current_timer_invincible = 0
	

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
		if(image_alpha <=0) return;
		
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
		
		if(state == state_dash_load)
		{
			progress_hollow_circle(x - 32 , y - 32,current_dash_load_timer+2,dash_load_timer,5 , 8, 32)
		}
		
		draw_option_on_elevator();
	}
	
	draw_player = function()
	{
		var _alp = current_timer_invincible > 0 ? wave(.5,.8,3) : 1;
		draw_sprite_ext(sprite_index,image_index,x,y,xscale * look_at , yscale , image_angle + angle , image_blend , image_alpha * _alp);
	}
	
	draw_drill = function()
	{
		if(!can_cave) 
		{
			draw_sprite_ext(spr_litou_hat,0,x,y - 10 - wave(1,-1,2) , xscale * look_at , yscale , 0 , image_blend , 1);
			return;
		}
		
		if(drill_white_timer>0) gpu_set_fog(true , c_dkgray , 1,0);
		
		var _dist = 8
		var _x = lengthdir_x(_dist , angle_direction);
		var _y = lengthdir_y(_dist*.8 , angle_direction);
		
		draw_sprite_ext(spr_drill_base,0,x + _x ,y + _y , xscale , yscale , 0 , image_blend , 1);
	
		_dist = 6
		_x += lengthdir_x(_dist , angle_direction);
		_y += lengthdir_y(_dist , angle_direction);
			
		drill.x = x + _x;
		drill.y = y + _y;
		draw_sprite_ext(spr_drill	 ,0,x + _x ,y + _y , xscale , yscale , drill.image_angle , image_blend , 1);
		
		gpu_set_fog(false , c_white , 1,0);
	}
	
	draw_drop_bar = function()
	{
		var _x = 64;
		var _y = GUI_HEIGHT - 16
		var _num = array_length(INVENTORY);
		for(var i = 0 ; i < _num ; i++)
		{
			var __x = _x + (i*SLOT_WIDTH);
			draw_sprite(spr_hud,i==INVENTORY_OPTION_SELECTED,__x,_y);
			
			if(INVENTORY[i]!=undefined)
			{
				draw_sprite_ext(INVENTORY[i].slot_sprite,0,__x,_y - (SLOT_WIDTH/2),1,1,0,c_white,1)
				
				draw_set_valign(fa_bottom)
				draw_set_halign(fa_center)
				
				
				
				draw_set_color(c_black);
				var _txt = $"{INVENTORY[i].slot_stack_current_number}"
				draw_text_scribble(__x  , _y , _txt);
				draw_set_color(c_white);
				draw_text_scribble(__x -1 , _y -1 , _txt);
				
				draw_set_halign(fa_left)
				draw_set_valign(fa_top)
			}
		}
		
		draw_text(_x-16 , _y - 80 , INVENTORY_OPTION_SELECTED)
	}
	
	draw_gui = function()
	{
		draw_healthbar(20,20,100 + energy_max,30,current_energy/energy_max * 100 , c_black , c_red , c_white , 0,true , true);
		
		draw_text(20,50,GAME_INFO.coins);
		
		draw_drop_bar()
	}
	
	draw_option_on_elevator = function()
	{
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
					_ins.when_interacted(id)
				}
			}
		}
		
		return _return;
	}
	
	exit_ground = function(_state = state_outside)
	{
		inside_ground = false;
		vspd = -8;
		state = _state;
		
		y = min(y , -max_y_outside)
	}
	
	enter_ground = function(_state = state_walk)
	{
		state = _state;
		y = max(y , -max_y_outside+1)
		vspd = 8;
		inside_ground = true;
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
		return( keyboard_check(ord("D")) - keyboard_check(ord("A")))
	}
	
	check_confirm = function()
	{
		return keyboard_check_pressed(vk_space);
	}
	
	//lerp circular que aponta a broca pro canto certo
	rotate_drill = function(_direction , _force)
	{

		angle_direction = lerp_angle(angle_direction,_direction , _force)
		angle_direction = wrap(angle_direction,0,359.9);
		
		drill.image_angle = lerp_angle(angle_direction,_direction , _force*.8)
		drill.image_angle = wrap(drill.image_angle,0,359.9);
		
	}

	can_i_be_hurt = function(_other)
	{
		return current_timer_invincible <=0;
	}

#endregion

#region state machine debaixo da terra

	//andando debaixo da terra
	state_walk = function()
	{
		image_blend = c_white
		
		check_interactables();
	
		var _direction = point_direction(x,y,mouse_x,mouse_y);
		var _spd = mouse_check_button(mb_left) && (point_distance(x,y,mouse_x,mouse_y) > 16) && !is_mouse_over_debug_overlay();
		
		rotate_drill(_direction, .1 + (_spd*.2))
		
		var _hspd = lengthdir_x(1,angle_direction)
		var _vspd = lengthdir_y(1,angle_direction)
	
		h_spd	= _hspd * current_speed * _spd;
		hspd	= lerp(hspd , h_spd , aceleration * acel_after_attack);
	
		v_spd	= _vspd * current_speed * _spd;
		vspd	= lerp(vspd , v_spd , aceleration * acel_after_attack)
	
		if(_spd || (abs(hspd) + abs(vspd))>1)
		{
			check_entity_to_drill();
		}
		
	
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
	
		rotate_drill(_direction, .3)
	
		if(number_is_between(angle_direction,90,270)) look_at = -1
		else look_at = 1;
		
		
		current_dash_load_timer = clamp(current_dash_load_timer+1,0,dash_load_timer)
		
		if(!mouse_check_button(mb_right))
		{
			state = state_dash_released;
			current_dash_timer = 0;
			
			rotate_drill(_direction, .8)
			
			var _x = lengthdir_x(dash_distance_max ,angle_direction)
			var _y = lengthdir_y(dash_distance_max ,angle_direction)
			var _dist = point_distance(x,y,x+_x,y+_y) / dash_flow_timer;
			
			var _frc =.5 + (current_dash_load_timer / dash_load_timer)*.5
			
			dash_speed = _dist * _frc;
			
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
	
	state_goup = function()
	{
		image_alpha = 0;
		vspd = lerp(vspd , -100 , .05);
	}
	
	state_hurt = function()
	{
		hspd	= lerp(hspd , 0 , aceleration * acel_after_attack * .8);
		vspd	= lerp(vspd , 0 , aceleration * acel_after_attack * .8);
		
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

	state = state_walk;

#endregion

#region state machine acima da terra

	gravity_force = .6;
	max_y_outside = 32
	on_ground = false;
	outside_speed = 5;
	jump_force = 5;

	state_outside = function()
	{
		image_blend = c_white
		
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
		rotate_drill(_direction, .6)
	
		if(sign(_hspd) != 0) 
		{
			look_at = sign(_hspd);
		}
		
		
		if(on_ground)
		{
			var _can = check_interactables();
			
			if(can_cave && number_is_between(angle_direction,180+1,360-1) && mouse_check_button_pressed(mb_left))
			{
				enter_ground();
			}
			else
			if(_can && check_confirm())
			{
				vspd = -8;
			}
		}
	}
	
	state_select = function()
	{
		
		image_blend = c_white
		
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
		inside_ground = false;
		state = state_outside;
	}
	
	chosing_level = false;
	current_choose = max(0,GAME_INFO.max_chunk_achiev div 10);
	elevator_follow = noone;
	

#endregion

max_y = (CHUNK_MAX * CHUNK_HEIGHT) + CHUNK_HEIGHT;
collision=function()
{
	var _multiply = speed_multiply_timer > 0 ? current_speed_multiply : 1
	
	var __x = hspd * _multiply;
	var __y = vspd * _multiply;
	
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
		
		var _movement = (abs(__x) + abs(__y))/50 * move_energy_cost
		current_energy -= max(_movement , still_energy_cost);
		current_energy = wrap(current_energy , 0 , energy_max);
		
		x += __x;
		y += __y;
	}
	
	var _offset = 0
	x = clamp(x , _offset , room_width - _offset);
	y = min(y , max_y);
	
	if(inside_ground) && y < -max_y_outside
	{
		exit_ground();
		image_alpha = 1;
	}
}


#region DEBUGGER

	my_debugger = noone;

	debug_create = function()
	{
		my_debugger = dbg_view("CAMERA OPTIONS",true)

		//dbg_section("Player");
		//dbg_text("Coisas");
		//dbg_checkbox(ref_create(self , "variable_name"),"")
		//dbg_slider(ref_create(self , "variable_name") , 0 , 3,"TEXTO: ",0.1)
		//dbg_text_input(	ref_create(self , "variable_name")	,"TEXTO: "	,DBG_TYPE_REAL)
		
		dbg_section("Movimentação");
		
			dbg_text_input(ref_create(self , "speed_walking")	 , "speed_walking"		, DBG_TYPE_REAL);
			dbg_text_input(ref_create(self , "current_speed")	 , "current_speed"		, DBG_TYPE_REAL);
			dbg_text_input(ref_create(self , "aceleration"	)	 , "aceleration"		, DBG_TYPE_REAL);
			dbg_text_input(ref_create(self , "move_energy_cost") , "move_energy_cost"	, DBG_TYPE_REAL);
		
		dbg_section("Dash");
		
			dbg_text_input(ref_create(self , "dash_load_timer"	)		, "dash_load_timer"		, DBG_TYPE_INT);
			dbg_text_input(ref_create(self , "dash_distance_max"	)	, "dash_distance_max"	, DBG_TYPE_INT);
			dbg_text_input(ref_create(self , "dash_flow_timer"	)		, "dash_flow_timer"		, DBG_TYPE_INT);
			
			dbg_text_input(ref_create(self , "dash_damage_multiply"	)	, "dash_damage_multiply"		, DBG_TYPE_REAL);
			
			dbg_text_input(ref_create(self , "dash_bust_energy_cost")	, "dash_bust_energy_cost"		, DBG_TYPE_REAL);
			dbg_text_input(ref_create(self , "state_dash_energy_cost")	, "state_dash_energy_cost"		, DBG_TYPE_REAL);
		
		dbg_section("Broca");
		
			dbg_text_input(ref_create(self , "damage")						, "damage"						, DBG_TYPE_REAL);
			dbg_text_input(ref_create(self , "dash_damage_multiply")		, "dash_damage_multiply"		, DBG_TYPE_REAL);
			
			dbg_text_input(ref_create(self , "damage_energy_cost_multiply")	, "damage_energy_cost_multiply"	, DBG_TYPE_REAL);
																			  
			dbg_text_input(ref_create(self , "timer_offset_attacks")		, "timer_offset_attacks"		, DBG_TYPE_INT);
			dbg_text_input(ref_create(self , "dash_timer_offset_attacks")	, "dash_timer_offset_attacks"	, DBG_TYPE_INT);
																			  
			dbg_text_input(ref_create(self , "push_force_when_attack")		, "push_force_when_attack"		, DBG_TYPE_REAL);
			dbg_text_input(ref_create(self , "push_force_when_attack_dash")	, "push_force_when_attack_dash"	, DBG_TYPE_REAL);
		
		dbg_section("Energy");
		
			dbg_text_input(ref_create(self , "energy_max")			, "energy_max"		, DBG_TYPE_REAL);
			dbg_text_input(ref_create(self , "current_energy")		, "current_energy"	, DBG_TYPE_REAL);
			
			
			dbg_text_input(ref_create(self , "still_energy_cost")			, "still_energy_cost"			, DBG_TYPE_REAL);
			dbg_text_input(ref_create(self , "move_energy_cost")			, "move_energy_cost"			, DBG_TYPE_REAL);
			dbg_text_input(ref_create(self , "dash_bust_energy_cost")		, "dash_bust_energy_cost"		, DBG_TYPE_REAL);
			dbg_text_input(ref_create(self , "damage_energy_cost_multiply")	, "damage_energy_cost_multiply"	, DBG_TYPE_REAL);
			dbg_text_input(ref_create(self , "state_dash_energy_cost")		, "state_dash_energy_cost"		, DBG_TYPE_REAL);
			
		dbg_section("Inventário")
		
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
