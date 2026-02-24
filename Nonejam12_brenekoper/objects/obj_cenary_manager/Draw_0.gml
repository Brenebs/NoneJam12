/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

draw_self();

var _num = array_length(array_cenary);
for(var i = 0 ; i < _num ; i++)
{
	
	var _camx1 = CAMERA_X+CAMERA_WIDTH/2;
	var _camy1 = CAMERA_Y+CAMERA_HEIGHT;
	var _camx2 = room_width/2;
	var _camy2 = 0;
	
	var _x = lerp(_camx1 , _camx2 ,  i / _num * .5);
	var _y = lerp(_camy1 , _camy2 ,  i / _num * .5);
	
	_y = min(_y , -20);
	draw_sprite_ext(array_cenary[i],i,_x,_y, 1 , 1 , 0 , c_white , 1);
}