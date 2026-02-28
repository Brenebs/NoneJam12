/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

list_damage = ds_list_create();
list_damaged = ds_list_create();

ray = 1;

damage = 1;

timer_between_hits = 30;
timer_between_hitscisual = timer_between_hits;
current_between_hits = 10;

old_position = new vector2(x,y);

random_positions = better_array_create(random(6),new vector2(x,y))

next_attack = noone;

check_next_instance = function()
{
	next_attack = noone;
	var _list = ds_list_create();
	
	var _num = collision_circle_list(x,y,ray,obj_mineral_father,false,true,_list,false);
	
	ds_list_shuffle(_list);
	
	for(var i = 0 ; i < _num ; i++)
	{
		var _current = ds_list_find_value(_list , i);
		
		if(ds_list_find_index(list_damaged,_current) == -1)
		{
			next_attack = _current;
		}
	}
	ds_list_destroy(_list)
	
	return next_attack != noone;
}

hurt_enemies = function()
{
	if(instance_exists(next_attack))
	{
		old_position.x = x;
		old_position.y = y;
		x = next_attack.x;
		y = next_attack.y;
		
		var _rng = point_distance(old_position.x, old_position.y,x,y) * .075;
								 
		var _num = array_length(random_positions)
		for(var i = 0 ; i < _num ;i++)
		{
			
			random_positions[i].x = lerp(old_position.x , x , i/(_num-1)) + random_range(-_rng,_rng);
			random_positions[i].y = lerp(old_position.y , y , i/(_num-1)) + random_range(-_rng,_rng);
		}
		
		current_between_hits = timer_between_hits;
		timer_between_hitscisual = timer_between_hits;
		
		next_attack.scale=1.5;
		next_attack.white_timer =  3;
		next_attack.life -= damage;
				
		if(next_attack.life<=0)
		{
			timer_between_hitscisual = timer_between_hits/2
			current_between_hits = 15;
			
			next_attack.destroy_function(0);
		}
		
		ray		*= .9;
		damage	*= .9;
		
		ds_list_add(list_damaged,next_attack);
		
		check_next_instance();
	}
	else
	if(!check_next_instance())
	{
		instance_destroy();
	}
}