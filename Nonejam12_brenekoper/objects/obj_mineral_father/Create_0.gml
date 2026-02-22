
image_index = random(image_number);

scale = 1;

white_timer = 0;

//image_xscale = scale;
//image_yscale = scale;

life = 10;

mineral_drop = obj_mineral_drop_father;

var _name = object_get_name(object_index);
var _split = string_split(_name,"obj_mineral");
var _drop_name = "obj_mineral_drop"+_split[1];

show_debug_message(_drop_name);

var _asset = asset_get_index(_drop_name)
if(object_exists(_asset))
{
	mineral_drop = _asset;
}

resistency = 1;

destroy_function = function()
{
	repeat(mineral_number)
	{
		var _ins = instance_create_layer(x,y,"Drops",mineral_drop);
		_ins.rarity = resistency;
	}
	
	instance_destroy();
}