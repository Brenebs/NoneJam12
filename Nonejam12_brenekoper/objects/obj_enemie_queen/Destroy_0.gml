/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

for(var i = 0 ; i < array_length(array_minions) ; i++)
{
	var _ins = array_minions[i];
		_ins.state = _ins.state_flow;
		_ins.direction_goto = point_direction(_ins.x,_ins.y,obj_player.x,obj_player.y);
}