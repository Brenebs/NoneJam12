
current_biom = 0;

bioms = 
[
	[spr_background_biom1 , (30  - .5) * CHUNK_HEIGHT , 1],
	[spr_background_biom2 , (55  ) * CHUNK_HEIGHT , 1],
	[spr_background_biom3 , (80  - .5) * CHUNK_HEIGHT , 1],
	[spr_background_biom4 , (105 - .5) * CHUNK_HEIGHT , 1],
	[spr_background_biom5 , (180 - .5) * CHUNK_HEIGHT , 1]
	
]

colors = 
[
	#6B4420	,
	#FDC689	,
	#FFD8DB	,
	c_yellow,
	#BAE57C
]
color_dark = make_colour_rgb(30, 2, 15);

color_len = array_length(colors);

global.color_effect = c_white
global.color_effect_bg = c_black

bioms_transition_offset = CHUNK_HEIGHT*3

bioms_len = array_length(bioms);

fx_merge = fx_create("_filter_outline");

var _r = colour_get_blue(	global.color_effect );
var _g = colour_get_green(	global.color_effect );
var _b = colour_get_blue(	global.color_effect );
fx_set_parameter(fx_merge, "g_OutlineColour", [_r, _g, _b, 1]);
fx_set_single_layer(fx_merge,true);
//

layer_set_fx("GroundEffect",fx_merge);