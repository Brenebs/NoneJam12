

speed = random(10);
direction = random(360);

rarity = 0;
timer_to_be_collected = 30;

being_collected = function()
{
	
	if(add_drop(object_index , sprite_index , value  ,number_to_add , stack_max, rarity))
	{
		instance_destroy();
	}
	
}

can_be_collected = function()
{
	return timer_to_be_collected<=0
}