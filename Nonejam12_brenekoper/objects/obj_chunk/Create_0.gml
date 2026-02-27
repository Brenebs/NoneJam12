image_yscale = CHUNK_HEIGHT / sprite_get_height(sprite_index);						   
image_xscale = room_width	/ sprite_get_width(sprite_index);

//if(array_length(global.array_chunks) <= id_chunk)
//{
//	global.array_chunks[id_chunk] = [];
//}

//if(!is_array(global.array_chunks[id_chunk]))
//{
//	global.array_chunks[id_chunk] = [];
	
//}


have_to_die = false;

my_array = variable_clone(global.array_chunks[id_chunk])
my_array = array_shuffle(my_array)
var _area_max = array_length(my_array);
var __y = bbox_top;

if(id_chunk == 0)
{
	__y = mean(bbox_top , bbox_bottom);
}

//show_debug_message($"chunk numero {id_chunk} criando {_area_max} minerios")

var _num = _area_max//irandom(_area_max)
for(var i = 0 ; i < _num ; i++)
{
	var _ins = instance_create_layer(irandom_range(bbox_left , bbox_right) , irandom_range(__y,bbox_bottom),"Minerals",my_array[i])
}


deactivated_instances = [] 
deactivate_instances = function()
{
	var _list = ds_list_create();
	var _num = collision_rectangle_list(bbox_left , bbox_top , bbox_right , bbox_bottom , [obj_mineral_father,obj_mineral_drop_father] , false , true , _list , false);
	
	for(var i = 0 ; i < _num ; i++)
	{
		var _current = ds_list_find_value(_list,i);
		
		if(point_in_rectangle(_current.x,_current.y,bbox_left , bbox_top , bbox_right , bbox_bottom))
		{
			array_push(deactivated_instances,_current);
			
			instance_deactivate_object(_current);
		}
	}

	ds_list_destroy(_list);
}

reactivate_instances = function()
{
	var _num = array_length(deactivated_instances)
	
	for(var i = 0 ; i < _num ; i++)
	{
		var _current = deactivated_instances[i];
		
		instance_activate_object(_current);
	}
	
	deactivated_instances = [];
}

destroy_instances = function()
{
	var _num2 = array_length(my_array);
	for(var j = 0 ; j < _num2 ; j++)
	{
		var _rock = my_array[j];
		instance_activate_object(_rock);
				
		show_debug_message($"      j =  {j} - {_rock}")
		instance_destroy(_rock , false);
	}
			
	delete my_array;
			
	show_debug_message($"destruindo chunk - index {id_chunk} - {id}")
			
	instance_destroy(id);
}