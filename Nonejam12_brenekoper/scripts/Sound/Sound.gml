global.sfx_values = {};
with(global.sfx_values) {
	falloff_multiplier = 1;
	falloff_factor = 1;
	falloff_model = audio_falloff_linear_distance_clamped;
	falloff_ref = 640 * .5 * falloff_multiplier;
	falloff_max = 360 * 1.25 * falloff_multiplier;
}

audio_falloff_set_model(global.sfx_values.falloff_model);

audio_group_set_gain(ag_musics, 0, 0);
audio_group_set_gain(ag_sfx, 0, 0);

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

function sfx_play_pos(_id, _x, _y, _gain = 1, _pitch_rand = 0, _loop = false, _gate = false, _priority = 0) {
	var _audio = noone;
	
	if is_array(_id) {
		_id = array_choose(_id);
	}
	
	if audio_exists(_id) {
		if _gate {
			audio_stop_sound(_id);
		}
	
		_audio = audio_play_sound_at(
			_id,
			_x,
			_y,
			0,
			global.sfx_values.falloff_ref,
			global.sfx_values.falloff_max,
			global.sfx_values.falloff_factor,
			_loop,
			_priority,
			_gain,
			0,
			1 + random_range(-_pitch_rand * .5, _pitch_rand * .5)
		);
	}
	
	return _audio
}
	
function sfx_play_emitter(_id, _emitter_id, _gain = 1, _pitch_rand = 0, _loop = false, _priority = 0) {
	var _audio = noone;
	
	if is_array(_id) {
		_id = array_choose(_id);
	}
	
	_audio = audio_play_sound_on(
		_emitter_id,
		_id,
		_loop,
		_priority,
		_gain,
		0,
		1 + random_range(-_pitch_rand * .5, _pitch_rand * .5)
	);
	
	return _audio
}

function audio_emitter_doppler(_emitter_id, _speed_x, _speed_y, _strength = .5) {
	var _cam_x = CAMERA_X + (CAMERA_WIDTH * .5);
	var _cam_y = CAMERA_Y + (CAMERA_HEIGHT * .5);
	
	var _emitter_x = audio_emitter_get_x(_emitter_id);
	var _emitter_y = audio_emitter_get_y(_emitter_id);
	
	var _distance_current = point_distance(_emitter_x, _emitter_y, _cam_x, _cam_y);	
	var _distance_next_f = point_distance(_emitter_x + _speed_x, _emitter_y + _speed_y, _cam_x, _cam_y);
	
	var _amount = (_distance_current - _distance_next_f) / UNIT;
	
	audio_emitter_pitch(_emitter_id, 1 + _amount * _strength);
}

global.electric_sound = false;

global.music = -1;
global.music_stop = -1;

function music_swap(_id) {
	if !audio_is_playing(_id) {
		if audio_is_playing(global.music) audio_stop_sound(global.music);
		global.music = sfx_play(_id, 1, 0, true);
	}
}

function music_stop(_id) {
	audio_sound_gain(_id, 0, 300);
	global.music_stop = _id;
	
	call_later(30, time_source_units_frames, fx() { audio_stop_sound(global.music_stop) });
}