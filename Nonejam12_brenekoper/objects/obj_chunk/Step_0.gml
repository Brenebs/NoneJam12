
var _num = obj_chunk_manager.player_current_chunk;
if(!number_is_between(id_chunk , _num-CHUNKS_OFFSET , _num+CHUNKS_OFFSET))
{
	
	deactivate_instances();
	
	instance_deactivate_object(id);
	
	obj_chunk_manager.create_chunks();
}

