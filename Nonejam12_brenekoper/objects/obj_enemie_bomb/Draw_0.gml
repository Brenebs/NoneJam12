/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if(activated)
{
	
	draw_set_color(c_red);
	
	var _frc = current_timer_to_explode / timer_to_explode;
	
	draw_set_alpha(.8*_frc)
	draw_circle(x,y,area_explosion * _frc , false);
	
	draw_set_alpha(1)
	draw_set_color(c_maroon);
	draw_circle(x,y,area_explosion , true);
	draw_circle(x,y,area_explosion-1 , true);
	draw_set_color(c_white);
}

// Inherit the parent event
event_inherited();

