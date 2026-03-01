
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

#region minerios

	var _sugar = new create_minerals(obj_mineral_1)
	with(_sugar)
	{
		add_interval(0,21 , 6 , .2 , 2 , 10);
	}

	var _chocolate_rb = new create_minerals( obj_mineral_roadblock_1)
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

	var _chocolate_rb = new create_minerals( obj_mineral_roadblock_2)
	with(_chocolate_rb)
	{
		add_interval(39 , 39 , 2 , 2 , 1,1);
	}

	var _white_chocolate = new create_minerals(obj_mineral_4)
	with(_white_chocolate)
	{
		add_interval(31,55 , 40 , .1 , 2 , 10);
	}

	var _coconut = new create_minerals(obj_mineral_5)
	with(_coconut)
	{
		add_interval(34,54 , 50 , .1 , 2 , 10);
	}

	var _caramelow = new create_minerals(obj_mineral_6)
	with(_caramelow)
	{
		add_interval(50,58 ,  , .1 , 2 , 10);
	}

	var _chocolate_rb = new create_minerals( obj_mineral_roadblock_3)
	with(_chocolate_rb)
	{
		add_interval(59 , 59 , 1 , 2 , 1,1);
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

	var _chocolate_rb = new create_minerals( obj_mineral_roadblock_4)
	with(_chocolate_rb)
	{
		add_interval(85 , 85 , 39 , 2 , 1,1);
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

	var _chocolate_rb = new create_minerals( obj_mineral_roadblock_5)
	with(_chocolate_rb)
	{
		add_interval(116 , 116 , 2 , 2 , 1,1);
	}

	var _chocolate_rb = new create_minerals( obj_mineral_roadblock_6)
	with(_chocolate_rb)
	{
		add_interval(130 , 130 , 2 , 2 , 1,1);
	}

	var _mineral = new create_minerals(obj_mineral_15)
	with(_mineral)
	{
		add_interval(116,132 ,  , .1 , 2 , 10);
	}
#endregion

#region inimigos

	var _fumiga		= new create_minerals( obj_enemie);
	var _mina		= new create_minerals( obj_enemie_bomb);
	var _fumirainha = new create_minerals( obj_enemie_queen);
	
	#region chocolate
	
		with(_fumiga)
		{
			add_interval(13 , 13 , , 1 , 1,1);
		}
	
		with(_fumiga)
		{
			add_interval(15 , 15 , , 1 , 1,1);
		}
	
		with(_fumiga)
		{
			add_interval(17 , 17 , , 1 , 1,1);
		}
	
		with(_fumiga)
		{
			add_interval(18 , 18 , , 1 , 1,1);
		}
	
	
		with(_fumiga)
		{
			add_interval(23 , 25 , , 1 , 1,1);
		}
	
		with(_fumiga)
		{
			add_interval(26 , 26 , , 1 , 3,3);
		}
	
		with(_fumiga)
		{
			add_interval(26 , 26 , , 1 , 3,3);
		}
	
	#endregion
	
	#region branco
	
		with(_fumiga)
		{
			add_interval(42 , 42 , , 1 , 1,1);
		}
		with(_fumiga)
		{
			add_interval(44 , 44 , , 1 , 1,1);
		}
		with(_mina)
		{
			add_interval(46 , 56 , , 1 , 1,1);
		}
		
		with(_fumiga)
		{
			add_interval(60 , 65 , , 1 , 1,1);
		}
		
		with(_fumirainha)
		{
			add_interval(70 , 70 , , 1 , 1,1);
		}
		
	#endregion

#endregion


function evade_teleport()
{
	var _ins = instance_nearest(x,y,obj_teleport_botton);
	if(_ins)
	{
		while(point_distance(x,y,_ins.x,_ins.y) < 80)
		{
			var _dir = point_direction(x,y,_ins.x,_ins.y);
			
			y += lengthdir_x(16*1.8 , _dir); 
			x += lengthdir_y(16 , _dir); 
		}
	}
}

function evade_teleport_height()
{
	var _ins = instance_nearest(x,y,obj_teleport_botton);
	if(_ins)
	{
		while(abs(y-_ins.y) < 200)
		{
			var _dir = sign(y - _ins.y);
			
			if(_dir  == 0) _dir = choose(-1,1);
			
			y += _dir; 
		}
	}
}

//var _mineral = new create_minerals(obj_mineral_16)
//with(_mineral)
//{
//	add_interval(131,155 ,  , .1 , 2 , 10);
//}


//var _mineral = new create_minerals(obj_mineral_roadblock_father)
//with(_mineral)
//{
//	add_interval(137,153 ,  , .1 , 2 , 10);
//}

