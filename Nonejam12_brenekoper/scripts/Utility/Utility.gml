// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações

//returna um vetor com x e y
function vector2(_x = 0, _y = _x) constructor {
		x = _x;
		y = _y;
						
		static get_magnitude = function(){
			var _mag = 0;
			if (x > 0 && y > 0){
				_mag =  sqrt((x * x) + (y * y))	
			}
			return _mag;
		}
			
		static normalize = function(){
			if ((x != 0) || (y != 0)){
			
				var _factor = 1/sqrt((x * x) + (y * y));
				x = _factor * x;
				y = _factor * y;
			}
				
			return self;
		}

		static get_speed = function() {
			return point_distance(0, 0, x, y);
		}
			
		static get_direction = function(_x_origin = 0, _y_origin = 0) {
			return point_direction(_x_origin, _y_origin, x, y);
		}
			
		static is_null = function() {
			return ((x == noone) and (y == noone)) or ((x == undefined) and (y == undefined));
		}

		static lengthdir = function(_length, _dir) {
			x = lengthdir_x(_length, _dir);
			y = lengthdir_y(_length, _dir);
		
			return self;
		}
			
		static set_value = function(_x, _y) {
			x = _x;
			y = _y;	
			return self;
		}
			
		static lerpto = function(_vec2, _amount) {
			if is_vector2(_vec2) {
				x = lerp(x, _vec2.x, _amount);
				y = lerp(y, _vec2.y, _amount);
			}
			return self;
		}
			
		static compare = function(_vec2){
			return (x == _vec2.x && y == _vec2.y);	
		}
	}
	
function simple_transform(_x = 0,_y = 0,_scale = 1) constructor
{
	x = _x;
	y = _y;
	scale = _scale
	
	static lerp_scale = function(_goto = 1 , _frc = .2)
	{
		scale = lerp(scale , _goto , _frc);
	}
}
	
//clamp buffado (evitarusar pq é pesado)	
function wrap(value, _min, _max) {
	if (value mod 1 == 0){
		while (value > _max || value < _min){
			if (value > _max) value += _min - _max - 1;
			else if (value < _min) value += _max - _min + 1;
		}
		return(value);
	} else {
		var vOld = value + 1;
		while (value != vOld){
			vOld = value;
			if (value < _min) value = _max - (_min - value);
			else if (value > _max) value = _min + (value - _max);
		}
		return(value);
	}
}	

//clamp buffado nerfado
function qwrap(value, _min, _max) {
	if (value > _max) return _min;
	else if (value < _min) return _max;
	else return value;
}

//como um round mas pra outros valores
function snap(value, _size) 
{
    return round(value / _size) * _size;
}

function lerp_angle(val1 , val2, amnt = .1)
{
	var _diff = angle_difference(val2,val1);
	val1 += _diff * amnt;
	return val1;
}

//retorna o valor só que menos 1, sempre garantindo que não será menor que 0
function max_timer(_val1)
{
	return max(_val1-1,0);
}

//lerp legal
function spring_lerp(_value, _spring_value, _target, _spring_percent, _percent){
	_spring_value = lerp(_spring_value, (_target - _value) * _spring_percent, _percent);
	return _spring_value;
}
	
function animation_end()
{
	if(!sprite_exists(sprite_index)) return false;
	
	var _current_frame	= image_index;
	var _frame_max		= image_number;
	var _next_frame		= image_speed * (sprite_get_speed(sprite_index)/GAME_SPEED)
	
	return _current_frame + _next_frame >= _frame_max;
}

function sprite_get_animated_image_index(sprite, offset = 0) 
{ 
	return ((current_time - offset) / 1000 * sprite_get_speed(sprite)) 
};
		
		
function number_is_between(_number_to_compare , _min = 0 , _max = 100)
{
	return clamp(_number_to_compare , _min , _max) == _number_to_compare
}
		
function goto_layer(_layer,_depth_offset = 0)
{
	var _lay = layer_get_id(_layer);
	
	var _exists = layer_exists(_lay)
	if(_exists)
	{
		layer = _lay;
		
		depth += _depth_offset
	}
	
	return _exists
} 

function camera_set_zoom(zoom , acel = .2)
{
	obj_camera.camera_zoom_acel = acel;
	obj_camera.camera_zoom		= zoom;
}

function camera_set_offset(_offset)
{
	obj_camera.offset = _offset;
}

function add_zero(_number)
{
	_number = string(_number);
	if(_number<10)
	{
		_number = $"0{_number}"
	}
	return _number
}

//convert to timer
function convert_to_timer(_timer)
{
	//60 return 1:00,00
	//65 return 1:05,00
	var _minutes , _sec , _mili;
		
	_mili	= add_zero(ceil(frac(_timer)*100) % 100);
		
	_timer -= frac(_timer); 
	_sec	= add_zero(_timer %	 60);
	_minutes= _timer div 60;
		
	var _txt = $"{_sec}.{_mili}"
	if(_minutes>0)
	{
		_txt = $"{_minutes}:" + _txt
	}
		
	return _txt;
}

//array_create mas não é bugado
function better_array_create(_lenght = 1 , _val = undefined)
{
	var _array = [];
	for(var i = 0 ; i < _lenght ; i++)
	{
		_array[i] = variable_clone(_val);
	}
	
	return variable_clone(_array);
}

#macro PLAYER_ARRAY []
function get_nearest_player(_x = x , _y = y)
{
	var _array = PLAYER_ARRAY;
	
	var _player = noone
	var _dist = infinity;
	var _len = array_length(_array);
	
	for(var i = 0 ; i < _len ; i++)
	{
		if(instance_exists(_array[i]))
		{
			var _ins = instance_nearest(_x,_y,_array[i]);
			
			if(!instance_exists(_ins))
			{
				continue;
			}
			
			var __dist = point_distance(_x,_y, _ins.x,_ins.y);
			
			if(_dist > __dist)
			{
				_dist = __dist;
				_player = _ins;
			}
		}
	}

	return _player;
}

function array_choose(_array) {
    return _array[irandom(array_length(_array)-1)];
}


function color_to_string(_value) {
	    var _b = (_value >> 16) & 0xFF;
		var _g = (_value >> 8) & 0xFF;
		var _r = _value & 0xFF;
		
		var _digits = "0123456789ABCDEF";
		
		var _hex_r = string_copy(_digits, (_r div 16) + 1, 1) + string_copy(_digits, (_r mod 16) + 1, 1);
		var _hex_g = string_copy(_digits, (_g div 16) + 1, 1) + string_copy(_digits, (_g mod 16) + 1, 1);
		var _hex_b = string_copy(_digits, (_b div 16) + 1, 1) + string_copy(_digits, (_b mod 16) + 1, 1);
		
		return "#" + _hex_r + _hex_g + _hex_b;
	}

#region Structs
	
	
	//retorna um struct cópia de outro
	function copy_struct(struct){
	    var key, value;
	    var newCopy = {};
	    var keys = variable_struct_get_names(struct);
	    for (var i = array_length(keys)-1; i >= 0; --i) {
	            key = keys[i];
	            value = struct[$ key];
	            variable_struct_set(newCopy, key, value)
	    }
	    return variable_clone(newCopy);
	}

	//retorna um struct com as mesmas variaveis que outro (não retorna os valores)
	function copy_struct_name(struct){
	    var key, value;
	    var newCopy = {};
	    var keys = variable_struct_get_names(struct);
	    for (var i = array_length(keys)-1; i >= 0; --i) {
	            key = keys[i];
	            value = 0;
	            variable_struct_set(newCopy, key, value)
	    }
	    return variable_clone(newCopy);
	}
	
	//adiciona a um struct variaveis faltosas
	function struct_copy_missing_variables(struct_to_read, struct_to_write) 
	{
        
		var struct_variables = struct_get_names(struct_to_read);
		var struct_variables_n = array_length(struct_variables);
		for(var i = 0; i < struct_variables_n; i++)
		{
		    var struct_variable = struct_variables[i];
		    var struct_to_read_value = struct_to_read[$ struct_variable];
            
		    if (struct_to_write[$ struct_variable] == undefined)
		    {
		        struct_to_write[$ struct_variable] = struct_to_read[$ struct_variable];
		    }
		    else if (is_struct(struct_to_read_value))
		    {
		        var struct_to_write_value = struct_to_write[$ struct_variable];
		        struct_copy_missing_variables(struct_to_read_value, struct_to_write_value);
		    }
		}
	}

	function struct_update_missing_variables(source_struct, destination_struct) 
	{
		// Get a list of variable names from the source struct
		var _source_variables = struct_get_names(source_struct);
		var _source_variables_count = array_length(_source_variables);
    
		// Get a list of variable names from the destination struct
		var _destination_variables = struct_get_names(destination_struct);
		var _destination_variables_count = array_length(_destination_variables);
    
		// Iterate over all variables in the source struct
		for (var _i = 0; _i < _source_variables_count; _i++) {
		    var _variable_name = _source_variables[_i];
		    var _source_value = source_struct[$ _variable_name];
		
		    // If the variable does not exist in the destination struct
		    if (destination_struct[$ _variable_name] == undefined) {
		        // Copy the variable from the source struct to the destination struct
		        destination_struct[$ _variable_name] = _source_value;
		    } 
		    // If the variable in the source struct is also a struct
		    else if (is_struct(_source_value)) {
		        var _destination_value = destination_struct[$ _variable_name];
		        // Recursively call the function to copy nested variables
		        struct_copy_missing_variables(_source_value, _destination_value);
		    }
		}
    
		_destination_variables_count = array_length(_destination_variables);
		
		// Iterate over all variables in the destination struct
		for (var _j = 0; _j < _destination_variables_count; _j++) {
		    var _destination_variable_name = _destination_variables[_j];
        
		    // If the variable does not exist in the source struct
		    if (source_struct[$ _destination_variable_name] == undefined) 
			{
		        // Remove the variable from the destination struct
		        //variable_struct_remove(destination_struct, _destination_variable_name);
				struct_remove(destination_struct, _destination_variable_name)
		    }
		}
	
		return destination_struct;
	}
	
	function variable_struct_get_all_names(_struct) 
	{
	
		var _result = variable_struct_get_names(_struct);
	
		for (var i = 0; i < array_length(_result); i++) {
			if is_struct(_struct[$ _result[i]]) {
				var _name = _result[i];
				_result[i] = variable_struct_get_all_names(_struct[$ _result[i]]);
				array_insert(_result[i], 0, $"${_name}");
			}
		}
	
		return _result;
	}
	
	function has_variable(_name, _element) 
	{
		var _val = false;
		if is_struct(_element) {
			_val = variable_struct_exists(_element, _name);
		}
		else if instance_exists(_element) {
			_val = variable_instance_exists(_element, _name);
		}
		return _val;
	}
	
	function struct_add_variable_once(_struct, _variable_name, _value = 0) 
	{
		if !has_variable(_variable_name, _struct) {
			_struct[$ _variable_name] = _value;
		}
	}
	
	//cria um struct baseado em uma instancia
	function create_struct_by_instance(_instance)
	{
		var _struct = {};
		
		// algumas variaveis que toda instancia tem, mas o variable_instance_get_names não reconhece
		static _array_variables_extras = ["x","y","gravity","gravity_direction","hspeed","vspeed","depth","image_xscale","image_yscale", "image_angle" , "direction"]
		
		var str = "";
		var array = variable_instance_get_names(_instance);
		
		//adiciona o array as variaveis obrigatórias
		array = array_union(array , _array_variables_extras);
		
		//show_debug_message("iniciando clonagem");
		
		//vai no array inteiro
		for (var i = 0; i < array_length(array); i++;)
		{
			//insere no struct o nome da variavel e seu valor
			var _get = variable_instance_get(_instance, array[i]);
		    //show_debug_message($"id={i} : name '{array[i]}' = {_get}");
			struct_set(_struct,array[i],_get)
		}
		
		//show_debug_message($"finalizado!\n{_struct}");
		
		return _struct;
	}
	
#endregion