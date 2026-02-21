
global.array_chunks = better_array_create(CHUNK_MAX + 1,[]);

function add_interval(_min_chunk , _max_chunk , _chunk_density = mean(_min_chunk , _max_chunk),_density_lerp = .1 , _min_density = 3 , _max_density = 10)
{
		
	min_chunk = min(_min_chunk , _max_chunk);
	max_chunk = max(_min_chunk , _max_chunk);
			
	chunk_density = clamp(_chunk_density , min_chunk , max_chunk);
		
	for(var i  = min_chunk ; i <= max_chunk ; i++)
	{
		var _offset = point_distance(0,i,0,chunk_density) * _density_lerp; 
			
		var _number = lerp(_max_density , _min_density , _offset);
			_number = clamp(_number , _min_density , _max_density);
			_number = round(_number)
			
		if(min_chunk == max_chunk)
		{
			_number = _max_density;
		}
			
		if(array_length(global.array_chunks)<=i)
		{
			global.array_chunks [i] = []; 
		}
		repeat(_number)
		{
			array_push(global.array_chunks[i],mineral_object);
		}
		
		//show_message($"no chunk {i}, serão criados {_number} {mineral_name}\n{global.array_chunks[i]}")
			
	}
		
}

function create_minerals(_object = obj_mineral_father) constructor
{
	data = []
	
	mineral_object	= _object
	
}

var _sugar = new create_minerals(obj_mineral_1)
with(_sugar)
{
	add_interval(0,21 , 6 , .2 , 2 , 10);
}

var _chocolate_rb = new create_minerals( obj_mineral_roadblock_father)
with(_chocolate_rb)
{
	add_interval(6 , 6 , 6 , 2 , 1,1);
}

var _chocolate = new create_minerals(obj_mineral_2)
with(_chocolate)
{
	add_interval(7,30 , 19 , .1 , 2 , 10);
}

var _peanut = new create_minerals(obj_mineral_3)
with(_peanut)
{
	add_interval(19,33 ,  , .2 , 1 , 5);
}

var _white_chocolate = new create_minerals(obj_mineral_4)
with(_white_chocolate)
{
	add_interval(31,55 ,  , .1 , 2 , 10);
}

var _coconut = new create_minerals(obj_mineral_5)
with(_coconut)
{
	add_interval(34,54 ,  , .1 , 2 , 10);
}

var _caramelow = new create_minerals(obj_mineral_6)
with(_caramelow)
{
	add_interval(50,58 ,  , .1 , 2 , 10);
}

var _strawberry = new create_minerals(obj_mineral_7)
with(_strawberry)
{
	add_interval(56,75 , , .1 , 2 , 10);
}

var _sugar_2 = new create_minerals(obj_mineral_8)
with(_sugar_2)
{
	add_interval(59,84 ,  , .1 , 2 , 10);
}

var _chocolate_2 = new create_minerals(obj_mineral_9)
with(_chocolate_2)
{
	add_interval(68,80 ,  , .1 , 2 , 10);
}

var _honey = new create_minerals(obj_mineral_10)
with(_honey)
{
	add_interval(81,105 ,  , .1 , 2 , 10);
}

var _caramelow2 = new create_minerals(obj_mineral_11)
with(_caramelow2)
{
	add_interval(84,97 ,  , .1 , 2 , 10);
}

var _brown_sugar = new create_minerals(obj_mineral_12)
with(_brown_sugar)
{
	add_interval(95,109 ,  , .1 , 2 , 10);
}

var _mineral = new create_minerals(obj_mineral_13)
with(_mineral)
{
	add_interval(106,130 ,  , .1 , 2 , 10);
}

var _mineral = new create_minerals(obj_mineral_14)
with(_mineral)
{
	add_interval(109,130 ,  , .1 , 2 , 10);
}

var _mineral = new create_minerals(obj_mineral_15)
with(_mineral)
{
	add_interval(116,132 ,  , .1 , 2 , 10);
}

var _mineral = new create_minerals(obj_mineral_16)
with(_mineral)
{
	add_interval(131,155 ,  , .1 , 2 , 10);
}

//var _mineral = new create_minerals(obj_mineral_roadblock_father)
//with(_mineral)
//{
//	add_interval(137,153 ,  , .1 , 2 , 10);
//}

