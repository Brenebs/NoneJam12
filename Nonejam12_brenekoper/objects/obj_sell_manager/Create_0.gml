/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

array_selling = better_array_create(3,undefined);
space_free = true;


add_selling_item = function(_new_item , position = 0)
{
	SELL_ARRAY[position] =  variable_clone(INVENTORY[INVENTORY_OPTION_SELECTED]);
	
	
	var _value = SELL_ARRAY[position].slot_value
	var _number = SELL_ARRAY[position].slot_stack_current_number;
	
	SELL_ARRAY[position].timer_to_sell = _value * _number * GAME_SPEED / 10;
	SELL_ARRAY[position].timer_to_sell_max = SELL_ARRAY[position].timer_to_sell;
}

selling_itens = function()
{
	var _num = array_length(array_selling)

	var _potency = CURRENT_WORLD ? 1 : .25;

	space_free = false;
	for(var i = 0 ;i < _num ; i++)
	{
		var _current = array_selling[i];
	
		if(is_undefined(array_selling[i]))
		{
			space_free = true;
		}
		else
		{
			_current.timer_to_sell -= _potency;
		
			if(_current.timer_to_sell<=0)
			{
				GAME_INFO.coins += _current.slot_stack_current_number * _current.slot_value;
				
				array_selling[i] = undefined;
				
				if(room == rm_real_world)
				{
					save_game();
				}
			}
		}
	}
}