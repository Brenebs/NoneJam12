/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor



if(instance_exists(obj_sell_manager))
{
	if(id_selling >= array_length(obj_sell_manager.array_selling))
	{
	
	}
	else
	{
		draw_self();

		if(!is_undefined(obj_sell_manager.array_selling[id_selling]))
		{
			var _y = y + 28;
			var _selling_item = obj_sell_manager.array_selling[id_selling];
		
			var _min = SELL_ARRAY[id_selling].timer_to_sell
			var _max = SELL_ARRAY[id_selling].timer_to_sell_max
			//progress_hollow_circle(x,y-32,_min , _max , 12 , 14 , 128);
			draw_donut(x, _y, 12, 14, 24, _min / _max);
		
			draw_sprite(_selling_item.slot_sprite , 0 , x , _y);
		
		
		}
	}
}

