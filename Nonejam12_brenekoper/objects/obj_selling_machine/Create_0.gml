/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

event_inherited();

when_interacted = function()
{
	do_boing();
	
	sfx_play(snd_player_collect, 1, .2);
	
	var _num = array_length(SELL_ARRAY)
	for(var i = 0 ;i < _num ; i++)
	{
		if(is_undefined(SELL_ARRAY[i]))
		{
			obj_sell_manager.add_selling_item(INVENTORY[INVENTORY_OPTION_SELECTED] , i);
			INVENTORY[INVENTORY_OPTION_SELECTED] = undefined;
			
			for(var j = 0 ; j < array_length(INVENTORY) ; j++)
			{
				if(j != INVENTORY_OPTION_SELECTED && INVENTORY[j] != undefined)
				{
					INVENTORY_OPTION_SELECTED = j;
					break;
				}
			}
			
			break;
		}
	}
}

can_be_interacted = function(_player = obj_player)
{
	return !_player.inside_ground && obj_sell_manager.space_free && INVENTORY[INVENTORY_OPTION_SELECTED] != undefined;
}

/*if(mouse_check_button_pressed(mb_middle))
			{
				if(room == rm_real_world)
				{
					room_goto(rm_gameplay)
				}
				else
				{
					room_goto(rm_real_world)
				}	
				
			}