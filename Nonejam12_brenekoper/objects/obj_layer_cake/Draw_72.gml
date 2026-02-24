
var _y = obj_camera.y;

for(var i = bioms_len-1 ; i >= 0 ; i--)
{
	
	if(_y > bioms[i , 1])
	{
		var _alp = 1 - ((_y - bioms[i , 1]) / bioms_transition_offset);
		bioms[i , 2] = lerp(bioms[i , 2],_alp , .5);
	}
	else
	{
		bioms[i , 2] = 1;
	}
	
	var _alpha = bioms[i , 2];
	
	draw_sprite_tiled_ext(bioms[i,0],0,0,-6,1,1,c_white,_alpha);
	
}
