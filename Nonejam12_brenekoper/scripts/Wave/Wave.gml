
function wave(_from, _to, _duration,_offset = 0){
	/// @desc wave(from, to, duration, offset)
	/// @arg from
	/// @arg to
	/// @arg duration
	/// @arg offset

	var _wave = (_to - _from) * 0.5;
	return _from + _wave + sin((((current_time * 0.001) + _duration * _offset) / _duration) * (pi * 2)) * _wave;
}

function wave_gameplay(_from, _to, _duration,_offset = 0)
{
	var _wave = (_to - _from) * 0.5;
	return _from + _wave + sin((((global.wave_pot*.01) + _duration * _offset) / _duration) * (pi * 2)) * _wave;

}