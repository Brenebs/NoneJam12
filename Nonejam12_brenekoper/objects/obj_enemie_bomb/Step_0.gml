/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// Inherit the parent event
event_inherited();

if(global.pause) return;

if(!activated)
{
	if(obj_player.image_alpha > 0)
	{
		var _dist = distance_to_object(obj_player);
		var _area = area_explosion*.8;
		
		//if(life_max*.7 <= life || distance_to_object(obj_player) < area_explosion/2)
		
		if(_dist < _area)
		{
			activated = true;
		
			sprite_index = spr_enemie_bomb_activated;
		
			scale = 1.5
		}
	}
}
else
{
	current_timer_to_explode++;
	
	if(current_timer_to_explode >= timer_to_explode)
	{
		exploding();
	}
}

