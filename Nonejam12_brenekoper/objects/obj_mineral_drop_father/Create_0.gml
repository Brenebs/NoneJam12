

speed = random(10);
direction = random(360);

timer_to_be_collected = 30;

being_collected = function()
{
	instance_destroy();
}

can_be_collected = function()
{
	return timer_to_be_collected<=0
}