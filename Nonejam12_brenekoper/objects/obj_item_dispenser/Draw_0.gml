/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

draw_self();

if(instance_exists(obj_sell_manager))
{
	if(id_selling >= array_length(obj_sell_manager.array_selling))
	{
		instance_destroy();
	}
	else
	if(!is_undefined(obj_sell_manager.array_selling[id_selling]))
	{
		var _selling_item = obj_sell_manager.array_selling[id_selling];
		
		var _min = SELL_ARRAY[id_selling].timer_to_sell
		var _max = SELL_ARRAY[id_selling].timer_to_sell_max
		//progress_hollow_circle(x,y-32,_min , _max , 12 , 14 , 128);
		draw_donut(x, y - 32, 12, 14, 24, _min / _max);
		
		draw_sprite(_selling_item.slot_sprite , 0 , x , y - 32);
		
		
		
		/*
			slot_object				 
			slot_sprite				 
			slot_value				 
			slot_rarity				 
			slot_stack_base			 
			slot_stack_current_number
		*/
	}
}

