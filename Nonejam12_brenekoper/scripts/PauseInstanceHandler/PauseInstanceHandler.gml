
//sistema que lida com o pause simplificado, ela para de se movimentar e para sua movimentação
//USE current_anim_speed pra definir sua velocidade de animação, 
function PauseInstanceHandler()
{
	if(!variable_instance_exists(id,"current_anim_speed"))
	{
		last_frame = image_index;
		current_anim_speed = image_speed;
		
		last_speedx = undefined;
		last_speedy = undefined;
	}
	
	if(global.pause)
	{
		image_index = last_frame;
		image_speed = 0;
		
		if(is_undefined(last_speedx))
		{
			last_speedx = hspeed;
			last_speedy = vspeed;
		}
	}
	else
	{
		last_frame = image_index;
		image_speed = current_anim_speed;
		
		if(!is_undefined(last_speedx))
		{
			hspeed = last_speedx;
			vspeed = last_speedy;
			last_speedx = undefined;
			last_speedy = undefined;
		}
	}
}