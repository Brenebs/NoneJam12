

speed = random(10);
direction = random(360);

rarity = 0;
timer_to_be_collected = 30;

follow_player = false;

distance_follow = 20 + UPGRADES.ext_magnet * (600 /  3);

being_collected = function()
{
	
	if(add_drop(object_index , sprite_index , value  ,number_to_add , stack_max, rarity))
	{
		instance_destroy();
	}
	else
	{
		follow_player = false;
		timer_to_be_collected = 40;
	}
	
}

can_be_collected = function()
{
	return timer_to_be_collected<=0
}