

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
	
	if(!collision_point(__x , __y,obj_chunk,true,true))
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
			
			if(instance_exists(total_chunks[_id]))
			{
				total_chunks[_id].reactivate_instances();
			}
			else
			{
				total_chunks[_id] = instance_create_layer(__x , __y,  "Chunks", obj_chunk,{id_chunk: _id});
			}
			
			
		}
	}
}