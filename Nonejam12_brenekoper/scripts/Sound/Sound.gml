function sfx_play(_id, _gain = 1, _pitch_rand = 0, _loop = false, _gate = false, _priority = 0) {
	var _audio = noone;
	
	if is_array(_id) {
		_id = array_choose(_id);
	}
	
	if _gate {
		audio_stop_sound(_id);
	}
	
	_audio = audio_play_sound(
		_id,
		_priority,
		_loop,
		_gain,
		0,
		1 + random_range(-_pitch_rand * .5, _pitch_rand * .5)
	);
	
	return _audio;
}