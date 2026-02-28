// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações

#macro SLOTS_MINERAL_MIN 2

#macro SLOT_WIDTH 32

global.drop_selected  = 0;
#macro INVENTORY_OPTION_SELECTED global.drop_selected
#macro INVENTORY global.game_save.drops_colected
#macro SELL_ARRAY obj_sell_manager.array_selling

#macro INVENTORY_MULTIPLYER 1

function add_drop(_object , _sprite ,  _value = 5 , _number_to_add = 1 , _stack_base = 2 , _rarity = 1)
{
	
	var _has_to_create_new = true;
	var _is_full = true;
	var _index_to_add = -4;
	
	var _num = array_length(INVENTORY);
	for(var i = 0 ; i < _num ; i++)
	{
		if(!is_undefined(INVENTORY[i]))
		{
			
			var _current = INVENTORY[i];
			
			var _same_object = _current.slot_object == _object
			var _same_sprite = _current.slot_sprite == _sprite 
			var _same_value  = _current.slot_value == _value 
			var _same_rarity = _current.slot_rarity == _rarity 
			var _same_stack  = _current.slot_stack_base == _stack_base
			var _can_fit	 = _current.slot_stack_current_number < (_current.slot_stack_base + ceil(_current.slot_stack_base * UPGRADES.ext_slot_lenght*INVENTORY_MULTIPLYER))
			
			show_debug_message(
				"TENTANDO ADICIONAR : \n" +
				"_same_object" + $"{_same_object}\n" +
				"_same_sprite" + $"{_same_sprite}\n" +
				"_same_value " + $"{_same_value}\n" +
				"_same_rarity" + $"{_same_rarity}\n" +
				"_same_stack " + $"{_same_stack}\n" +
				"_can_fit	 " + $"{_can_fit}\n" 
			
			)
			
			if(_same_object && _same_sprite && _same_value && _same_rarity && _same_stack && _can_fit	)
			{
				_is_full = false;
				_index_to_add = i;
				_has_to_create_new = false;
				
				break;
			}
		}
		else
		{
			if(_index_to_add == -4)
			{
				_index_to_add = i;
				_is_full = false;
			}
			
			
		}
	}
	
	if(!_is_full && _index_to_add >= 0)
	{
		if(_has_to_create_new)
		{
			var _new_construct = new create_drop_index(_object , _sprite , _value , _stack_base , _rarity);
			INVENTORY[_index_to_add] = _new_construct;
		}
		
		if(!variable_struct_exists(INVENTORY[_index_to_add] , "add_value"))
		{
			INVENTORY[_index_to_add].add_value = add_value_to_drop;
		}
		
		INVENTORY[_index_to_add].add_value(_number_to_add);
		
		
		return true;
	}
	
	return false;
}


function create_drop_index(_object , _sprite , _value , _stack_base , _rarity) constructor
{
	slot_object				  = _object
	slot_sprite				  = _sprite
	slot_value				  = _value;
	slot_rarity				  = _rarity;
	slot_stack_base			  = _stack_base
	slot_stack_current_number = 0
	
	add_value = add_value_to_drop;
	
}

function add_value_to_drop(_value)
{
	slot_stack_current_number += _value;
	
	var _num_max = slot_stack_base + ceil(slot_stack_base * UPGRADES.ext_slot_lenght*INVENTORY_MULTIPLYER);
	
	show_debug_message($"{slot_stack_current_number}-{_num_max}-{slot_stack_base}");
		
	if(slot_stack_current_number > _num_max)
	{
		
		
		var _max = _current
		var _rest = slot_stack_current_number - _num_max;
		slot_stack_current_number = _num_max;
		
		
			
		if(!add_drop(slot_object , slot_sprite , slot_value , _rest , slot_stack_base , slot_rarity))
		{
			//show_message(self)
			{
				var _ins = instance_create_layer(obj_player.x,obj_player.y,"Drops",slot_object);
				_ins.number_to_add = _rest;
			}
		}
	}
}

function drop_half(_x , _y)
{
	var _num = array_length(INVENTORY);
	for(var i = 0 ; i < _num ; i++)
	{
		if(!is_undefined(INVENTORY[i]))
		{
			
			var _current = INVENTORY[i];
			
			var _frc = lerp(2,1.2,UPGRADES.ext_lost_drops)
			
			var _number_to_loss = ceil(_current.slot_stack_current_number / _frc);
			repeat(_number_to_loss)
			{
				var _ins = instance_create_layer(_x , _y , "Minerals" , _current.slot_object);
				_ins.timer_to_be_collected = 1000;
			}
			
			_current.slot_stack_current_number -= _number_to_loss;
			if(_current.slot_stack_current_number<=0)
			{
				delete INVENTORY[i]
				INVENTORY[i] = undefined;
			}
		}
	}
}