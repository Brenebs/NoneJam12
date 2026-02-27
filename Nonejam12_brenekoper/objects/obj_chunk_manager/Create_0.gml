
timer_to_check_player = 0;

player_current_chunk = 0;

total_chunks = []

get_player_current_chunk = function()
{
	//var _player = get_nearest_player();
	//if(instance_exists(_player))
	var _y = obj_camera.y	
	
	player_current_chunk = clamp((_y) div CHUNK_HEIGHT,CHUNKS_OFFSET,CHUNK_MAX-CHUNKS_OFFSET);
	
}

create_chunks = function()
{
	
	
	//for(var i = 0; i < array_length(total_chunks) ; i++)
	//{
	//	if(!is_undefined(total_chunks[i]))
	//	{
	//		instance_destroy(total_chunks[i]);
	//	}
	//}
	
	for(var i = -CHUNKS_OFFSET ; i < CHUNKS_OFFSET+1 ; i++)
	{
		create_chunk_on_id(player_current_chunk+i)
	}
	
}

create_chunk_on_id = function(_id = 0)
{
	if(_id>CHUNK_MAX) return;
	
	var __x = room_width/2 
	var __y = (_id) * CHUNK_HEIGHT + (CHUNK_HEIGHT/2)
	
	var _collision = collision_point(__x , __y,obj_chunk,true,true)
	if(!_collision)
	{
		var _create_new = false
		if(array_length(total_chunks) <= _id)
		{
			_create_new = true;
		}
		else
		if(is_undefined(total_chunks[_id]))
		{
			_create_new = true;
		}
		
			
		
		if(_create_new)
		{
			//show_debug_message("CRIEI")
			total_chunks[_id] = instance_create_layer(__x , __y,  "Chunks", obj_chunk,{id_chunk: _id});
		}
		else
		{
			//show_debug_message("revivi")
			instance_activate_object(total_chunks[_id]);
			
			if(instance_exists(total_chunks[_id]) && total_chunks[_id].object_index == obj_chunk)
			{
				total_chunks[_id].reactivate_instances();
			}
			else
			{
				total_chunks[_id] = instance_create_layer(__x , __y,  "Chunks", obj_chunk,{id_chunk: _id});
			}
			
			
		}
	}
	else
	{
		total_chunks[_id] = _collision;
	}
}

reset_everything = function()
{
	var _num = array_length(total_chunks);
	instance_activate_layer("Chunks");
	instance_activate_layer("Minerals");
	
	show_debug_message("destruindo geral")
	
	var _timer = 0; 
	
	for(var i = 0 ; i < _num ; i++)
	{
		var _current = total_chunks[i];
		
		//instance_activate_object(_current);
		
		show_debug_message($"i =  {i} - {_current}")
		
		with(_current)
		{
			have_to_die = true;
			
			_timer++;
			call_later(_timer,time_source_units_frames,destroy_instances);
			
		}
	}
	
	_timer += 10
	call_later(_timer , time_source_units_frames , function()
	{
		with(obj_chunk)
		{
			show_debug_message($"quase n fui destruido hehe {object_index}")
			instance_destroy();
		}
	
		with(obj_mineral_father)
		{
			show_debug_message($"quase n fui destruido hehe {object_index}")
			instance_destroy();
		}
	
		with(obj_mineral_drop_father)
		{
			show_debug_message($"quase n fui destruido hehe {object_index}")
			instance_destroy();
		}
	})
}

generate_world = function()
{
	get_player_current_chunk();

	total_chunks = better_array_create(player_current_chunk+1,undefined);

	create_chunks();
}

deactivated_list = [];
deactivate_instances = function()
{
	var _ins = id;
	var _y = y;
	
	with(all)
	{
		if(_ins != id && _y > y)
		{
			show_message($"eu sou {object_get_name(object_index)} - id {id}");
			
			if(object_is_ancestor(object_index , obj_interact_item_father) || object_index == obj_item_dispenser || object_index == obj_tree)
			{
				show_message($"fui guardado  {object_get_name(object_index)} - id {id}");
				array_push(_ins.deactivated_list , _ins);
				instance_deactivate_object(id);
			}
		}
	}
}

reactivate_instances = function()
{
	var _num = array_length(deactivated_list);
	for(var i = 0 ; i < _num ; i++)
	{
		instance_activate_object(deactivated_list[i]);
	}
	
	deactivated_list = [];
}


var _sep_elevators = 10
for(var i = 10 ; i < CHUNK_MAX ; i+= _sep_elevators)
{
	var _index = instance_create_layer(room_width/2 , i*CHUNK_HEIGHT + CHUNK_HEIGHT , "Chunks"  , obj_teleport_botton);
		_index.id_chunk = i div 10;
}


