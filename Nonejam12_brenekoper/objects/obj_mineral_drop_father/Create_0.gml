

speed = random(10);
direction = random(360);

rarity = 0;
timer_to_be_collected = 30;

follow_player = false;
player_dash = false;

distance_follow = 20 + UPGRADES.ext_magnet * (64 /  3);

lerp_scale	= 0
scale		= random_range(.8,1.5)

offset = random(2);

being_collected = function()
{
	
	if(add_drop(object_index , sprite_index , value  ,number_to_add , stack_max, rarity))
	{
		sfx_play(snd_player_collect, 1, .33);
		instance_destroy();
	}
	else
	{
		player_dash = false;
		follow_player = false;
		timer_to_be_collected = 40;
	}
	
}

can_be_collected = function()
{
	return timer_to_be_collected<=0
}