/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

var _selling_lenght = array_length(obj_sell_manager.array_selling);

if(instance_exists(obj_sell_manager))
{
	if(id_selling >= _selling_lenght)
	{
	
	}
	else
	{
		image_index = clamp(_selling_lenght - id_selling,0,image_number-1);
		
		draw_self();
		var _num = clamp(_selling_lenght - id_selling,0,3)
		for(var i = id_selling ; i < id_selling+_num ; i++)
		{
			var _frc = (24/3)*_num;
			
			var _lrp = _num > 1 ? (i-id_selling) / (_num-1) : .5;
			var _x = x + lerp(-_frc , _frc , _lrp)
			var _y = y + 28;
			
			
			
			if(i < _selling_lenght && !is_undefined(obj_sell_manager.array_selling[i]))
			{
				
				var _selling_item = obj_sell_manager.array_selling[i];
		
				var _min = SELL_ARRAY[i].timer_to_sell
				var _max = SELL_ARRAY[i].timer_to_sell_max
				//progress_hollow_circle(x,y-32,_min , _max , 12 , 14 , 128);
				draw_donut(_x, _y, 12, 14, 24, _min / _max);
		
				draw_sprite_ext(_selling_item.slot_sprite , 0 , _x , _y,1,1,180,c_white,1);
		
		
			}
			else
			if(i < _selling_lenght)
			{
				var _frc = wave(0,2,2.5,(id_selling+i)*.2)
				draw_set_color(c_gray);
				draw_circle(_x,_y , 2 + _frc,true);
				draw_set_color(c_white);
			}
		}

		
	}
}

