/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if(white_timer)
{
	gpu_set_fog(true , c_ltgray , 1,0);
}

var _num = array_length(array_sprites)
for(var i = 0 ; i < _num ; i++)
{
	
	draw_sprite_ext(sprite_index , image_index , array_sprites[i].x,array_sprites[i].y,1 * scale, 1 * scale,1,image_blend , 1);
}




if(white_timer)
{
	gpu_set_fog(false , c_white , 1,0);
}