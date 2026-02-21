

#region

	life = 1;
	life_max = 1;
	
	hspd = 0;
	vspd = 0;

#endregion

#region

	xscale = 1;
	yscale = 1;
	angle = 0;	
	look_at = 1;

	draw_entity = function()
	{
		draw_self();
	}

#endregion

#region

	state = function()
	{
	
	}
	
	state_machine = function()
	{
		state();
	}
	
	
	collision = function()
	{
		x += hspd;
		y += vspd;
	}

#endregion