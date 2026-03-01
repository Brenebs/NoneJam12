/// @description Insert description here
// You can write your code in this editor



if(UPGRADES.ext_life_saver && nearest>0)
{
	var _area_col = LIFE_SAVER_AREA;
	var _p = collision_circle(x,y,_area_col,[obj_player],false,false);
	
	var _area = LIFE_SAVER_AREA * nearest

	_area *= wave(1.4,1.5,3);

	draw_set_colour(#6dff59);
	draw_set_circle_precision(32);
	
	
	draw_set_alpha(.08);
	draw_circle(x,y,_area,false);
	gpu_set_blendmode(bm_add);
	draw_circle(x,y,_area,false);
	gpu_set_blendmode(bm_normal);
	draw_set_alpha(1);
	
	// Inherit the parent event
	event_inherited();
	
	if(_p)
	{
		var _frc = wave(1,5,3) * (1-(point_distance(x,y,_p.x,_p.y) / _area_col)) * 3;
		draw_circle(x,y,_frc,false);
		draw_line_width(x,y,_p.x,_p.y,_frc*.9);
	}
	
	draw_circle(x,y,_area-.5,true);
	draw_circle(x,y,_area,true);
	draw_circle(x,y,_area+.5,true);
	
	draw_set_colour(c_white);
	draw_circle(x,y,_area,true);
	draw_set_circle_precision(24);
	
	nearest-=.05
}
else
{
	// Inherit the parent event
event_inherited();
}