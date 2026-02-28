/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
var _wid = current_between_hits / timer_between_hitscisual * 8;

var _x = x
var _y = y;

var _num = array_length(random_positions);
for(var i = 0 ; i < _num ; i++)
{
	var _frc = _wid * ((i+1)/_num);
	
	draw_line_width(_x,_y,random_positions[i].x,random_positions[i].y,_frc);
	
	_x = random_positions[i].x;
	_y = random_positions[i].y;
	
	draw_circle(_x , _y,_frc,false)
	
}

draw_line_width(_x,_y,old_position.x,old_position.y,_wid);