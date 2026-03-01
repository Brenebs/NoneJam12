

//se eu posso ou não pausar agora
can_pause = true;

pausing_game = function(_force_pause = !global.pause)
{
	//global.pause = _force_pause;
	if (_force_pause and !instance_exists(obj_pause) and !instance_exists(obj_modal)) instance_create_depth(0, 0, 0, obj_pause);
	//fazer mais coisa aqui
}